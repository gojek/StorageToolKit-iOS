//
//  LeastRecentlyModifiedComparator.swift
//  StorageCleaner
//
//  Created by Amit Samant on 18/02/22.
//

import Foundation

/// Container struct for comparision function for comparing file according to least recent first basis
public struct LeastRecentlyModifiedComparator {
    
    /// Compares two fiel url and return true if the lhs was more recently modified than rhs
    public static func compare(_ lhs: URL, _ rhs: URL) -> Bool {
        let lhsDate = lhs.getLastAccessDate()
        let rhsDate = rhs.getLastAccessDate()
        switch (lhsDate, rhsDate) {
        case let (.some(lhsDate), .some(rhsDate)):
            if lhsDate == rhsDate {
                return true
            } else if lhsDate > rhsDate {
                return false
            } else {
                return true
            }
        case (.none, .some),
            (.some, .none),
            (.none,.none):
            return true
        }
    }
}
