//
//  CleanUpConstraint.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Abstract protocol for creating clean up constrainsts
public protocol CleanUpConstraint {
    /// Function checks if the current contraint is met and returns true if case met or false in case it does not
    /// - Returns: return Bool
    func isMet() -> Bool
}
