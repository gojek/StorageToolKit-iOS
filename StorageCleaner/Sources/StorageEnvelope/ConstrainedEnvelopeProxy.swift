//
//  ConstrainedEnvelopeProxy.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// ConstrainedEnvelopeProxy acts as a proxy which check for of provided constraint is met or not and prevent or execute the call to the delegate if the constraint is met or not
public final class ConstrainedEnvelopeProxy: StorageEnvelope {
    
    /// Clean up contraint to enforce
    private var constraint: CleanUpConstraint
    /// Storage envelope to delegate to
    private var delegate: StorageEnvelope
    
    /// ConstrainedEnvelopeProxy initialiser
    /// Acts as a proxy which check for of provided constraint is met or not and prevent or execute the call to the delegate if the constraint is met or not
    /// - Parameters:
    ///   - constraint: Clean up contraint to enforce
    ///   - delegate: Storgae envelope to delegate to
    public init(constraint: CleanUpConstraint, delegate: StorageEnvelope) {
        self.constraint = constraint
        self.delegate = delegate
    }
    
    public func findRemovableItems() -> RemovableItems {
        if (constraint.isMet()) {
            return delegate.findRemovableItems()
        } else {
            return EmptyRemovableItems()
        }
    }
}
