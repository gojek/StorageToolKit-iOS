//
//  StorageEnvelopes.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// An composing implementation of StorageEnvelope which combine two or more enevelopes into a combine envelop
public final class StorageEnvelopes: StorageEnvelope {
    
    /// backing envelopes to be combine
    private var envelopes: [StorageEnvelope]
    
    /// Variadic init for StorageEnvelopes
    ///
    /// An composing implementation of StorageEnvelope which combine two or more enevelopes into a combine envelop
    /// - Parameter envelopes:envelopes to be combine
    public init(_ envelopes: StorageEnvelope...) {
        self.envelopes = envelopes
    }
    
    /// StorageEnvelopes init
    ///
    /// An composing implementation of StorageEnvelope which combine two or more enevelopes into a combine envelop
    /// - Parameter envelopes:envelopes to be combine
    public init(envelopes: [StorageEnvelope]) {
        self.envelopes = envelopes
    }

    public func findRemovableItems() -> RemovableItems {
        let removableItemsList = envelopes.map { $0.findRemovableItems() }
        guard let first = removableItemsList.first else {
            return EmptyRemovableItems()
        }
        let otherArray = removableItemsList[1..<removableItemsList.endIndex]
        return otherArray.reduce(first) { (first: RemovableItems, next: RemovableItems) -> RemovableItems in
            return first.plus(other: next)
        }
    }
}
