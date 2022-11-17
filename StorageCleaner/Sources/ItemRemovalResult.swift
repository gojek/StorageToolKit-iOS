//
//  ItemRemovalResult.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

public class ItemRemovalResult {
    
    /// Space free by cleaner in bytes
    public var freedSpaceInBytes: Int64
    /// Space that was not able to be free after cleanup due to some errors in byte
    public var unremovedItemsSpaceInBytes: Int64
    /// URL's set that were succesfully removed
    public var removedItemUris: Set<URL>
    /// URL to error map for file that was not able to deleted due to errors
    public var unremovedItems: [URL: Error]
    
    /// Creates ItemRemovalResult with provided attributes
    /// - Parameters:
    ///   - freedSpaceInBytes: Space free by cleaner in bytes
    ///   - unremovedItemsSpaceInBytes: Space that was not able to be free after cleanup due to some errors in byte
    ///   - removedItemUris: URL's set that were succesfully removed
    ///   - unremovedItems: URL to error map for file that was not able to deleted due to errors
    public init(
        freedSpaceInBytes: Int64,
        unremovedItemsSpaceInBytes: Int64,
        removedItemUris: Set<URL>,
        unremovedItems: [URL: Error]
    ) {
        self.freedSpaceInBytes = freedSpaceInBytes
        self.unremovedItemsSpaceInBytes = unremovedItemsSpaceInBytes
        self.removedItemUris = removedItemUris
        self.unremovedItems = unremovedItems
    }
    
    /// Removed files count
    public var removedItemCount: Int {
        removedItemUris.count
    }
    
    /// File count that were not able to removed cause of some errors
    public var unremovedItemCount: Int {
        unremovedItems.count
    }
}
