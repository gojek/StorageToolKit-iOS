//
//  StorageCleanerWorker.swift
//  StorageCleaner
//
//  Created by Amit Samant on 18/02/22.
//

import Foundation
import WorkManager

public typealias FileFilter = (_ fileURL: URL) -> Bool

/// Responsible to schedule cleanup job periodically to delete image caches
public class StorageCleanerWorker {
    
    private let config: StorageCleanerConfig
    private let performanceTracker: PerformanceTracker?
    private let storageCleanerPerformanceTrackingKey = "Disk Cleaner Performance"
    private let storageCleanerTaskKey = "disk_cleaner"
    private let excludedFileList = ["Cache.db", "Cache.db-wal", "Cache.db-shm"]
    private let cacheRootDirectory: URL?
    
    /// Creates PercentageStorageSpaceAvailabilityConstraint
    /// - Parameters:
    ///   - config: StorageCleanerConfig comforming object
    ///   - performanceTracker: PerformanceTracker comforming object
    ///   - cacheRootDirectory: optional cacheRootDirectory description
    public init(
        config: StorageCleanerConfig,
        performanceTracker: PerformanceTracker?,
        cacheRootDirectory: URL? = nil
    ) {
        self.config = config
        self.performanceTracker = performanceTracker
        self.cacheRootDirectory = cacheRootDirectory
    }
    
    private var fsCahceURL: URL? {
        let systemDefaultCacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        guard let cachesDirectory = cacheRootDirectory ?? systemDefaultCacheDirectory else {
            return nil
        }
        return cachesDirectory
            .appendingPathComponent("ImageDownloadCache")
            .appendingPathComponent("fsCachedData")
    }
    
    // Exclude the designated file from rempvable items list
    private func excludingFilesFilter(_ file: URL) -> Bool {
        return excludedFileList.contains(file.lastPathComponent) == false
    }
    
    /// Performs the cleanup based on ``StorageCleanerConfig`` and storage info from ``DiskSpaceProvider``
    public func doWork() {
        // Tracks the performance of clean up task
        performanceTracker?.startMeasuring(identifier: storageCleanerPerformanceTrackingKey)
        defer {
            performanceTracker?.stopMeasuring(identifier: storageCleanerPerformanceTrackingKey)
        }
        
        guard let cachesDirectory = fsCahceURL else {
            return
        }

        let diskSpaceProvider = DiskSpaceProvider()
        
        do {
            // This constraint only allows call to delegate enevolope if the current available size is less than or equal to the threshold percentage, other wise ConstrainedEnvelopeProxy returns empty removable items
            let envelope = ConstrainedEnvelopeProxy(
                constraint: PercentageStorageSpaceAvailabilityConstraint(
                    comparator: <=,
                    spaceInPercentage: config.lenientCleanupThresholdInPercentage,
                    diskSpaceProvider: diskSpaceProvider
                ),
                
                // This envelopes get asked for removable items if the above contraint is met, this envelop contains sub envelop and when the removable item is called upon this it merges the result from sub enveloped
                delegate: StorageEnvelopes(
                    
                    // This envelop fetches the stale files which are not used in the a set time duration
                    try LegacyStaleFilesEnvelope(
                        directoryURL: cachesDirectory,
                        filter: excludingFilesFilter,
                        thresholdTimeInterval: config.cacheFileAgeLimitInTimeInterval
                    ),
                    
                    // This constraint only allows call to delegate evenloe if the current avaiaable space is <= to the space in byte provided
                    ConstrainedEnvelopeProxy(
                        constraint: ExactStorageSpaceAvailabilityConstraint(
                            comparator: <=,
                            spaceInBytes: config.strictCleanupThresholdInBytes,
                            diskSpaceProvider: diskSpaceProvider
                        ),
                        // This envelope gets the exact amount of removable file if available after deleting which the freed size will be the provided  size limit
                        delegate: try DirectoryEnvelope(
                            directoryURL: cachesDirectory,
                            filter: excludingFilesFilter,
                            fileComparator: LeastRecentlyModifiedComparator.compare,
                            sizeLimitInBytes: config.cacheDirSizeLimitInBytes
                        )
                    )
                )
            )
            let receiver = StorageCleanerResultReceivers(
                    DebugConsoleReciever(),
                    AnalyticsResultReceiver(performanceTracker: performanceTracker)
            )
            let cleaner = Cleaner(envelope: envelope, receiver: receiver)
            cleaner.clean()
        } catch {
            debugPrint(error)
        }
    }
    
    /// Schedules the periodic cleanup job
    public func scheduleCleanup() {
        WorkManager.shared.enqueueUniquePeriodicWork(
            id: storageCleanerTaskKey,
            interval: config.cleanUpInterval,
            work: doWork,
            doesNotPerformOnLowPower: true,
            onQueue: DispatchQueue.global(qos: .background)
        )
    }
    
    /// Cancel already scheduled cleanup job
    public func cancelScheduledCleanup() {
        WorkManager.shared.cancelQueuedPeriodicWork(withId: storageCleanerTaskKey)
    }
}
