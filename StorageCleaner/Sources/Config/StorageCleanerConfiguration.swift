//
//  StorageCleanerConfiguration.swift
//  StorageCleaner
//
//  Created by Amit Samant on 18/02/22.
//

import Foundation

/// Default storage configuration constants
public struct StorageCleanerDefaultConfig {
    /// 25 % of total disk storage available
    public static let lenientCleanupThresholdInPercentage: Float = 0.25
    /// 512 MB
    public static let strictCleanupThresholdInBytes: Int64 = 512 * 1024 * 1024
    /// 20 Days
    public static let cacheFileAgeLimitInDays: Int = 20
    /// 80 MB
    public static let cacheDirSizeLimitInBytes: Int64 = 80 * 1024 * 1024
    /// 2 Days
    public static let cleanUpInterval: TimeInterval = 2 * 24 * 60 * 60
}

/// Represets default concrete implementation of ``StorageCleanerConfig``
public struct StorageCleanerConfiguration: StorageCleanerConfig {
    
    public var isEnabled: Bool = true
    
    public var lenientCleanupThresholdInPercentage: Float
    
    public var strictCleanupThresholdInBytes: Int64
    
    public var cacheFileAgeLimitInDays: Int
    
    public var cacheDirSizeLimitInBytes: Int64
    
    public var cleanUpInterval: TimeInterval
    
    public init(isEnabled: Bool = true, lenientCleanupThresholdInPercentage: Float, strictCleanupThresholdInBytes: Int64, cacheFileAgeLimitInDays: Int, cacheDirSizeLimitInBytes: Int64, cleanUpInterval: TimeInterval) {
        self.isEnabled = isEnabled
        self.lenientCleanupThresholdInPercentage = lenientCleanupThresholdInPercentage
        self.strictCleanupThresholdInBytes = strictCleanupThresholdInBytes
        self.cacheFileAgeLimitInDays = cacheFileAgeLimitInDays
        self.cacheDirSizeLimitInBytes = cacheDirSizeLimitInBytes
        self.cleanUpInterval = cleanUpInterval
    }
    
    /// Returns a StorageCleanerConfiguration with default values from ``StorageCleanerDefaultConfig`` constants
    /// - Returns: Object of StorageCleanerConfiguration
    public static func `default`() -> StorageCleanerConfiguration {
        StorageCleanerConfiguration(
            isEnabled: true,
            lenientCleanupThresholdInPercentage: StorageCleanerDefaultConfig.lenientCleanupThresholdInPercentage,
            strictCleanupThresholdInBytes: StorageCleanerDefaultConfig.strictCleanupThresholdInBytes,
            cacheFileAgeLimitInDays: StorageCleanerDefaultConfig.cacheFileAgeLimitInDays,
            cacheDirSizeLimitInBytes: StorageCleanerDefaultConfig.cacheDirSizeLimitInBytes,
            cleanUpInterval: StorageCleanerDefaultConfig.cleanUpInterval
        )
    }
}
