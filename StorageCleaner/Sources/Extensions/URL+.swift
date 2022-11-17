//
//  URL+.swift
//  StorageCleaner
//
//  Created by Amit Samant on 18/02/22.
//

import Foundation

enum FileTypeError: Error {
    case notADirectory
    case resourceValueNotFound
}

extension URL {
    
    /// Return the size of content at url, it can be file size or diretory's meta data size
    /// - Returns: size of content in bytes
    func getSizeOfContent() -> Int64 {
        let size = try? FileManager.default.attributesOfItem(atPath: path)[.size] as? NSNumber
        let intSize = Int64(truncating: size ?? 0)
        return intSize
    }
    
    /// Returns last access date of that
    /// - Returns: Date when the file assicoated with the url was last accessed
    func getLastAccessDate() -> Date? {
        let resourceValues = try? resourceValues(forKeys: [.contentAccessDateKey])
        return resourceValues?.contentAccessDate
    }
    
    /// Checks if the current URL is of a directory
    /// - Returns: return true if is a directory otherwise false
    func isDirectory() throws -> Bool {
        let resourceKeys = Set<URLResourceKey>([.nameKey, .isDirectoryKey])
        guard let resourceValues = try? resourceValues(forKeys: resourceKeys),
              let isDirectory = resourceValues.isDirectory else {
                  throw FileTypeError.resourceValueNotFound
              }
        return isDirectory
    }
    
    /// Checks if the current url is of a directory or fails
    func assertDirectory() throws {
        guard try isDirectory() else {
            throw FileTypeError.notADirectory
        }
    }
}
