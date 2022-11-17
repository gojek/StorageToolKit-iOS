//
//  StorageEnvelope.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Protocol encapsulating an directory enevelope resposible to provide removable items
public protocol StorageEnvelope {
    /// Returns the removable items, according to the implementation provided by the conforming concrete implementation
    /// - Returns: returns RemovableItems
   func findRemovableItems() -> RemovableItems
}
