//
//  DirectoryEnvelope.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Directory Enveloper is responsible to collect removable files from provioded directory
public final class DirectoryEnvelope: StorageEnvelope {
    
    /// Directory to fetchf file from, this directory is traversed in depth first fashion so the file included are also from relative subdirectories
    private var directoryURL: URL
    /// File fileter to apply on collected file
    private var filter: FileFilter? = nil
    /// File comparitor to sort the files
    private var fileComparator: ((URL, URL) -> Bool)?
    /// Size limit to trim the file limit
    private var sizeLimitInBytes: Int64? = nil
    
    /// Creates a new DirectoryEnvelope
    /// - Parameters:
    ///   - directoryURL: Directory to fetchf file from, this directory is traversed in depth first fashion so the file included are also from relative subdirectories
    ///   - filter: File fileter to apply on collected file
    ///   - fileComparator: File comparitor to sort the files
    ///   - sizeLimitInBytes: Size limit to trim the file limit
    public init(directoryURL: URL, filter: FileFilter? = nil, fileComparator: ((URL, URL) -> Bool)?, sizeLimitInBytes: Int64? = nil) throws {
        try directoryURL.assertDirectory()
        self.directoryURL = directoryURL
        self.filter = filter
        self.fileComparator = fileComparator
        self.sizeLimitInBytes = sizeLimitInBytes
    }
    
    public func findRemovableItems() -> RemovableItems {
        guard let directoryEnumerator = FileManager.default.enumerator(at: directoryURL, includingPropertiesForKeys: [URLResourceKey.isDirectoryKey]) else {
            return EmptyRemovableItems()
        }
        
        let fileURLs = directoryEnumerator.compactMap{ (content: Any) -> URL? in
            let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])
            guard let contentURL = content as? URL,
                  let resourceValues = try? contentURL.resourceValues(forKeys: resourceKeys),
                  let isDirectory = resourceValues.isDirectory, isDirectory == false else {
                      return nil
                  }
            if let filter = filter, filter(contentURL) == false {
                return nil
            }
            return contentURL
        }
        
        let files = RemovableFiles(files: fileURLs)
        
        let sorted: RemovableItems
        if let comparator = fileComparator {
            sorted = files.sort(comparator: comparator)
        } else {
            sorted = files
        }
        
        var trimmed: RemovableItems
        if let sizeLimitInBytes = sizeLimitInBytes {
            let sizeToRemove = max((files.sizeInBytes - sizeLimitInBytes),0)
            trimmed = sorted.trimToSize(bytes: sizeToRemove)
        } else {
            trimmed = sorted
        }
        
        return trimmed
    }
}
