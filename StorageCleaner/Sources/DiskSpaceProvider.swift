//
//  DiskSpaceProvider.swift
//  StorageCleaner
//
//  Created by Amit Samant on 16/02/22.
//

import Foundation

/// Utility class to get device disk space
public class DiskSpaceProvider {
    
    /// Usage of disk storage to calculate space against
    public enum UsageType {
        case importantUsage
        case opportunisticUsage
    }
    
    private let homeDirectoryPath = NSHomeDirectory() as String
    private let homeDirectoryUrl = URL(fileURLWithPath: NSHomeDirectory() as String)
    
    /// Get total disk space in bytes
    /// - Returns: returns total disk space in bytes
    public func getTotalDiskSpace() throws -> Int64 {
        let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: homeDirectoryPath)
        let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value
        return space ?? 0
    }
    
    /// Fetch the available according to provided usage tyep
    /// - Parameter usageType: usage type of disk space
    /// - Returns: returns size
    public func getFreeDiskSpace(forUsageType usageType: UsageType) throws -> Int64 {
        let size: Int64?
        switch usageType {
        case .importantUsage:
            let resourceKey = URLResourceKey.volumeAvailableCapacityForImportantUsageKey
            let resourceValues = try homeDirectoryUrl.resourceValues(forKeys: [resourceKey])
             size = resourceValues.volumeAvailableCapacityForImportantUsage
        case .opportunisticUsage:
            let resourceKey = URLResourceKey.volumeAvailableCapacityForOpportunisticUsageKey
            let resourceValues = try homeDirectoryUrl.resourceValues(forKeys: [resourceKey])
            size = resourceValues.volumeAvailableCapacityForOpportunisticUsage
        }
        return size ?? 0
    }
    
    /// Get free disk space irrelevent to usage type iOS 13 prior API
    /// - Returns: returns size
    public func getFreeDiskSpace() throws -> Int64 {
        let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: homeDirectoryPath)
        let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
        return freeSpace ?? 0
    }
    
}
