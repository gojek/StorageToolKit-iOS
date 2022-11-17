//
//  AnalyticsResultReceiver.swift
//  StorageCleaner
//
//  Created by Amit Samant on 23/02/22.
//  Copyright © 2022 PT GoJek Indonesia. All rights reserved.
//

import Foundation

/// AnalyticsResultReceiver is StorageCleanerResultReceiver's concerete implementation which is responsible to report removal result data points to provided performance tracker
public final class AnalyticsResultReceiver: StorageCleanerResultReceiver {

    private let storageCleanerTrackingKey = "Disk Cleaner"
    private let freedSpaceTrackingKey = "Disk Cleaner: Freed Space"
    private let unremovedSpaceTrackingKey = "Disk Cleaner: Unremoved Space"
    private let removedItemCountTrackingKey = "Disk Cleaner: Removed Count"
    private let unremovedItemCountTrackingKey = "Disk Cleaner: Unremoved Count"

    private let performanceTracker: PerformanceTracker
    private let attributesMapProvider: (() -> [String: String])?
    
    /// AnalyticsResultReceiver init
    ///
    /// AnalyticsResultReceiver is StorageCleanerResultReceiver's concerete implementation which is responsible to report removal result data points to provided performance tracker
    /// - Parameter performanceTracker: performace tracker where the perfomance metric should be reported to
    public init?(performanceTracker: PerformanceTracker?, attributesMapProvider: (() -> [String: String])? = nil) {
        guard let performanceTracker = performanceTracker else {
            return nil
        }
        self.performanceTracker = performanceTracker
        self.attributesMapProvider = attributesMapProvider
    }
    
    public func receive(_ result: ItemRemovalResult) {
        performanceTracker.startMeasuring(identifier: storageCleanerTrackingKey)
        performanceTracker.addMetrics(
            identifier: storageCleanerTrackingKey,
            metrics: [
                freedSpaceTrackingKey: result.freedSpaceInBytes,
                unremovedSpaceTrackingKey: result.unremovedItemsSpaceInBytes,
                removedItemCountTrackingKey: Int64(result.removedItemCount),
                unremovedItemCountTrackingKey: Int64(result.unremovedItemCount)
            ]
        )
        if let attributesMapProvider = attributesMapProvider {
            let attributes = attributesMapProvider()
            performanceTracker.addAttributes(
                identifier: storageCleanerTrackingKey,
                attributes: attributes
            )
        }
        performanceTracker.stopMeasuring(identifier: storageCleanerTrackingKey)
    }
    
}
