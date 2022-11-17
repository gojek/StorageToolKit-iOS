//
//  RemovableItems.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Protocol encapsulating items that are removable
public protocol RemovableItems {
    
    /// counts of removable items
    var count: Int { get }
    
    /// Commulative size of all removable
    var sizeInBytes: Int64 { get }
    
    /// Responsible to return sorted variant of removable items, according to the implementation of concrete type
    /// - Returns: sorted variant of removable items
    func sort(comparator: (URL, URL) -> Bool) -> RemovableItems
    
    /// Responsible to return trimmed varient of removable item, accroding to the implementation of concrete type
    /// - Returns: trimmed varient of removable item
    func trimToSize(bytes: Int64) -> RemovableItems
    
    /// Dry run the clean up and genrates the removal result but do not perform actual clean up, accroding to the implementation of concrete type
    /// - Returns: removal result
    func dryRun() -> ItemRemovalResult
    
    /// Clean/Deletes the remivable items and return removal result, accroding to the implementation of concrete type
    /// - Returns: removal result
    func remove() -> ItemRemovalResult
    
    /// Combine provided removable result with current instance, accroding to the implementation of concrete type
    /// - Returns: removal result
    func plus(other: RemovableItems) -> RemovableItems
}
