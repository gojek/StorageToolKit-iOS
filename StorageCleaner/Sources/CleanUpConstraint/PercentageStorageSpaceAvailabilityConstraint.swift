//
//  PercentageStorageSpaceAvailabilityConstraint.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Constraint that checks the available disk space against total disk space of device, in terms of provided percentage
/// - E.G. Device storage is 100 GB and Free Space is 25 GB
///     - The comparator is passed as <=
///     - The spaceInPercentage is passed as 0.25 representing 25% of storage
///     - Then when isMet() is call it will yield true
/// - If the Free Space is now 24 GB
///     - It will again yeild true
/// - if the Free Space is now 26 GB
///     - It will yeild false
public final class PercentageStorageSpaceAvailabilityConstraint: CleanUpConstraint {
    
    /// Comparitor of spaceInPercentage against availableSpaceInPercentage  you can either pass and closure with float compared with float or you could pass any boolean operation like <=, >=, <,> as comparitors
    private var comparator: (_ availableSpaceInPercentage: Float,_ spaceInPercentage: Float) -> Bool
    
    /// The threshold percentage of space to check the constraint againsts, this percentage is used to compare against percentage of space that is currently free in our device
    ///  e.g pass 0.25 for stating that 25% of storage should be compared againsts available space percentage using the provided comparator
    private var spaceInPercentage: Float
    
    private var diskSpaceProvider: DiskSpaceProvider
    
    /// PercentageStorageSpaceAvailabilityConstraint
    ///
    /// that checks the available disk space against total disk space of device, in terms of provided percentage
    /// - Parameters:
    ///   - comparator: Comparitor of spaceInPercentage against availableSpaceInPercentage  you can either pass and closure with float compared with float or you could pass any boolean operation like <=, >=, <,> as comparitors
    ///   - spaceInPercentage: The threshold percentage of space to check the constraint againsts, this percentage is used to compare against percentage of space that is currently free in our device
    ///   - diskSpaceProvider: Instance of disk space provider
    public init(comparator: @escaping (Float, Float) -> Bool, spaceInPercentage: Float, diskSpaceProvider: DiskSpaceProvider) {
        self.comparator = comparator
        self.spaceInPercentage = spaceInPercentage
        self.diskSpaceProvider = diskSpaceProvider
    }

    public func isMet() -> Bool {
        let totalSpaceInBytes = (try? diskSpaceProvider.getTotalDiskSpace()) ?? 0
        let availableSpaceInBytes = (try? diskSpaceProvider.getFreeDiskSpace(forUsageType: .importantUsage)) ?? 0
        let availableSpaceInPercentage = Float(availableSpaceInBytes) / Float (totalSpaceInBytes)
        return comparator(availableSpaceInPercentage, spaceInPercentage)
    }
}
