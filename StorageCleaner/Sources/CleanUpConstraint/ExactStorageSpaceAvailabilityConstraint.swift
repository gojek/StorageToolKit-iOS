//
//  ExactStorageSpaceAvailabilityConstraint.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Constraint that checks the available disk space against total disk space of device, in terms of provided size in bytes
/// - E.G. Device storage is 100 GB and Free Space is 512 MB
///     - The comparator is passed as <=
///     - The spaceInPercentage is passed as 512 * 1024 * 1024 representing 512 MB of storage
///     - Then when isMet() is call it will yield true
/// - If the Free Space is now 500 MB
///     - It will again yeild true
/// - if the Free Space is now 513 MB
///     - It will yeild false
public final class ExactStorageSpaceAvailabilityConstraint: CleanUpConstraint {
    
    /// Comparitor of spaceInPercentage against availableSpaceInPercentage  you can either pass and closure with float compared with float or you could pass any boolean operation like <=, >=, <,> as comparitors
    private var comparator: (_ availableSpaceInBytes: Int64,_ spaceInBytes: Int64) -> Bool
    /// The threshold size of space to check the constraint againsts, this size is used to compare against size of space that is currently free in our device
    ///  e.g pass 512 * 1204 * 1024  for stating that 512 MB of storage should be compared againsts available space size using the provided comparator
    private var spaceInBytes: Int64

    private var diskSpaceProvider: DiskSpaceProvider
    
    /// Creates PercentageStorageSpaceAvailabilityConstraint
    /// - Parameters:
    ///   - comparator: Comparitor of spaceInPercentage against availableSpaceInPercentage  you can either pass and closure with float compared with float or you could pass any boolean operation like <=, >=, <,> as comparitors
    ///   - spaceInBytes: The threshold size of space to check the constraint againsts, this percentage is used to compare against percentage of space that is currently free in our device **in bytes**
    ///   - diskSpaceProvider: Instance of disk space provider
    public init(comparator: @escaping (Int64, Int64) -> Bool, spaceInBytes: Int64, diskSpaceProvider: DiskSpaceProvider) {
        self.comparator = comparator
        self.spaceInBytes = spaceInBytes
        self.diskSpaceProvider = diskSpaceProvider
    }
    
    public func isMet() -> Bool {
        let availableSpaceInBytes = (try? diskSpaceProvider.getFreeDiskSpace(forUsageType: .importantUsage)) ?? 0
        return comparator(availableSpaceInBytes, spaceInBytes)
    }
}
