//
//  StorageCleanerConfig.swift
//  StorageCleaner
//
//  Created by Amit Samant on 18/02/22.
//

import Foundation

/// Represents configuration requirements of storage cleaner
public protocol StorageCleanerConfig {
    
    /// Whether clean-up is enabled.
    var isEnabled: Bool { get set }
    
    /// Lenient clean-up consist of file-age-based deletion of cache files. It is a low-impact,
    /// low-risk type of clean-up. So, generally we should be able to run it without any concern
    /// to the surrounding storage condition/availability.
    ///
    /// That being said, this property could be used to control even lenient clean-ups.
    ///
    /// This `Float` value represents a percentage of remaining available storage space before
    /// we'd allow lenient clean-up to proceed.
    ///
    /// For example, a value of 1.0 effectively means that we'll always allow lenient clean-up
    /// to happen every time. (Because available storage space would always be less than 100%).
    ///
    /// Meanwhile, a value of 0.0 means that lenient operation would never be run. (Because
    /// storage space amount couldn't possibly be lesser than 0%.)
    var lenientCleanupThresholdInPercentage: Float { get set }
    
    /// Strict clean-up consist of a more aggressive deletion strategy. It is a high-impact,
    /// high-risk clean-up. Unless we're critically low on storage, it's advisable to never
    /// run this kind of operation at all.
    ///
    /// This `Int64` value represents the exact number of remaining available bytes in the
    /// storage before we'd allow strict clean-up to happen.
    ///
    /// A value of `Int64.Magnitude` could be passed to ensure strict clean-up would be run
    /// in every opportunities. That said, doing so is not recommended.
    var strictCleanupThresholdInBytes: Int64 { get set }
    
    /// As part of lenient clean-up, we're going to remove old cache files (based on their
    /// creation timestamp metadata).
    ///
    /// This `Int` value represents a day threshold to determine whether a file can
    /// be categorized as old or not.
    var cacheFileAgeLimitInDays: Int { get set }
    
    /// As part of strict clean-up, we're going to ensure that the cache directory won't ever
    /// cross a particular size limit.
    ///
    /// This `Int64` value represents that limit (in bytes).
    var cacheDirSizeLimitInBytes: Int64 { get set }
    
    /// Interval in secods for periodic cleanup
    var cleanUpInterval: TimeInterval { get set }
    
}

extension StorageCleanerConfig {
    
    public func toMap() -> [String: String] {
        return [
            "is_cleanup_enabled": isEnabled.description,
            "lenient_cleanup_threshold_pct": (lenientCleanupThresholdInPercentage * 100).description,
            "strict_cleanup_threshold_bytes":
                strictCleanupThresholdInBytes.description,
            "cache_file_age_limit_days": cacheFileAgeLimitInDays.description,
            "cache_dir_size_limit_bytes": cacheDirSizeLimitInBytes.description
        ]
    }
    
    var cacheFileAgeLimitInTimeInterval: TimeInterval {
        Double(cacheFileAgeLimitInDays) * 24 * 60 * 60
    }
}
