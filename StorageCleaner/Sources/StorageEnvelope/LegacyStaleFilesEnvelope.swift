//
//  LegacyStaleFilesEnvelope.swift
//  Launchpad
//
//  Created by Amit Samant on 21/02/22.
//  Copyright © 2022 PT GoJek Indonesia. All rights reserved.
//

import Foundation

/// This envelope is responsible for fetching stale file from provided directory
public final class LegacyStaleFilesEnvelope: StorageEnvelope {
    
    /// Directory url to retrieve files from
    private var directoryURL: URL
    /// File filter to apply on files, use this to exclude any files from cleanup
    private var filter: FileFilter? = nil
    /// Time interval after which a file is considered stale
    private var thresholdTimeInterval: TimeInterval
    
    /// Create a new LegacyStaleFilesEnvelope
    /// - Parameters:
    ///   - directoryURL: Directory url to retrieve files from
    ///   - filter: File filter to apply on files, use this to exclude any files from cleanup
    ///   - thresholdTimeInterval: Time interval after which a file is considered stale
    public init(directoryURL: URL, filter: FileFilter? = nil, thresholdTimeInterval: TimeInterval) throws {
        try directoryURL.assertDirectory()
        self.directoryURL = directoryURL
        self.filter = filter
        self.thresholdTimeInterval = thresholdTimeInterval
    }
    
    public func findRemovableItems() -> RemovableItems {
        guard let directoryEnumerator = FileManager.default.enumerator(at: directoryURL, includingPropertiesForKeys: [URLResourceKey.isDirectoryKey]) else {
            return EmptyRemovableItems()
        }
        
        let fileURLs = directoryEnumerator.compactMap{ (content: Any) -> URL? in
            let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])
            guard let contentURL = content as? URL,
                  let resourceValues = try? contentURL.resourceValues(forKeys: resourceKeys),
                  let isDirectory = resourceValues.isDirectory,
                  isDirectory == false,
                  isStale(contentURL) == true else {
                      return nil
                  }
            if let filter = filter, filter(contentURL) == false {
                return nil
            }
            return contentURL
        }
        
        let files = RemovableFiles(files: fileURLs)
        return files
    }
    
    /// Checks the last accessed time vs the current time time diffrence and compare that with provided time interval to check if the file is stale
    /// - Parameter fileURL: url of file
    /// - Returns: returns true if file is stale otherwise false
    private func isStale(_ fileURL: URL) -> Bool {
        guard let fileLastAccessDate = fileURL.getLastAccessDate() else {
            return false
        }
        let diff = abs(Date().timeIntervalSince(fileLastAccessDate))
        return diff >= thresholdTimeInterval
    }
    
}
