//
//  EmptyRemovableItems.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Empty concrete implementation of RemovableItems
public final class EmptyRemovableItems: RemovableItems {
    
    public var count: Int { 0 }
    public var sizeInBytes: Int64 { 0 }
    
    public func trimToSize(bytes: Int64) -> RemovableItems {
        return EmptyRemovableItems()
    }
    
    public func dryRun() -> ItemRemovalResult {
        ItemRemovalResult(
            freedSpaceInBytes: 0,
            unremovedItemsSpaceInBytes: 0,
            removedItemUris: Set<URL>(),
            unremovedItems: [:]
        )
    }
    
    public func remove() -> ItemRemovalResult {
        ItemRemovalResult(
            freedSpaceInBytes: 0,
            unremovedItemsSpaceInBytes: 0,
            removedItemUris: Set<URL>(),
            unremovedItems: [:]
        )
    }
    
    public func sort(comparator: (URL, URL) -> Bool) -> RemovableItems {
        EmptyRemovableItems()
    }
    
    public func plus(other: RemovableItems) -> RemovableItems {
        EmptyRemovableItems()
    }
}
