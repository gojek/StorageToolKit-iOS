//
//  RemovableFiles.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Removable file is an concrete implementation of RemovableItems having url base files as the deletable items
public final class RemovableFiles: RemovableItems {
    
    /// Urls of files
    var fileURls: [URL]
    
    /// Count of elligible files
    public var count: Int { fileURls.count }
    lazy public var sizeInBytes: Int64 = {
        return fileURls.reduce(0) { partialResult, url -> Int64 in
            let fileSize = url.getSizeOfContent()
            return partialResult + fileSize
        }
    }()
    
    /// RemovableFiles init
    ///
    /// Removable file is an concrete implementation of RemovableItems having url base files as the deletable items
    /// - Parameter files: file urls
    public init(files: [URL]) {
        self.fileURls = Array(Set(files))
    }
    
    public func sort(comparator: (URL, URL) -> Bool) -> RemovableItems {
        let sortedFiles = fileURls.sorted(by: comparator)
        return RemovableFiles(files: sortedFiles)
    }

    public func trimToSize(bytes sizeInBytes: Int64) -> RemovableItems {
        guard sizeInBytes > 1 else {
            return EmptyRemovableItems()
        }
        var count = 0
        var size: Int64 = 0
        for url in fileURls {
            if size >= sizeInBytes {
                break
            }
            let fileSize = url.getSizeOfContent()
            size += fileSize
            count += 1
        }
        return RemovableFiles(files: Array(fileURls[0..<count]))
    }

    public func remove() -> ItemRemovalResult {
        return commit(shouldActuallyDelete: true)
    }

    public func dryRun() -> ItemRemovalResult {
        return commit(shouldActuallyDelete: false)
    }
    
    /// Deletes the file depending on `shouldActuallyDelete` vauleu and genrates the removal result
    /// - Parameter shouldActuallyDelete: if the action should commited or should just calculate the size that could have freed if deleted
    /// - Returns: removal result
    func commit(shouldActuallyDelete: Bool) -> ItemRemovalResult {
        var removedUrls = Set<URL>()
        var unremovedItemsSpaceInBytes: Int64 = 0
        var unremovedUrlsToCause = [URL: Error]()
        var removableSizeInBytes: Int64 = 0

        fileURls.forEach { fileURL in
            let fileSize = fileURL.getSizeOfContent()

            if shouldActuallyDelete {
                let path = fileURL.path
                do {
                    try FileManager.default.removeItem(atPath: path)
                    removedUrls.insert(fileURL)
                    removableSizeInBytes += fileSize
                } catch {
                    unremovedUrlsToCause[fileURL] = error
                    unremovedItemsSpaceInBytes += fileSize
                }
            } else {
                removedUrls.insert(fileURL)
                removableSizeInBytes += fileSize
            }
        }

        return ItemRemovalResult(
            freedSpaceInBytes: removableSizeInBytes,
            unremovedItemsSpaceInBytes: unremovedItemsSpaceInBytes,
            removedItemUris: removedUrls,
            unremovedItems: unremovedUrlsToCause
        )
    }
    
    public func plus(other: RemovableItems) -> RemovableItems {
        guard let otherRemovableFiles = other as? RemovableFiles else {
            return self
        }
        let mergedFileURL = fileURls + otherRemovableFiles.fileURls
        let setOfMergedFileURL = Set(mergedFileURL)
        return RemovableFiles(files: Array(setOfMergedFileURL))
    }

}
