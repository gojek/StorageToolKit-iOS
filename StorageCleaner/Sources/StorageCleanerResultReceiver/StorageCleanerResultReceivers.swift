//
//  StorageCleanerResultReceivers.swift
//  StorageCleaner
//
//  Created by Amit Samant on 15/02/22.
//

import Foundation

/// Composing implamentation which combine two or more recivers into a new combined reciever
public final class StorageCleanerResultReceivers: StorageCleanerResultReceiver {
    
    /// Backing recivers to report the cleaner result to
    private var delegates: [StorageCleanerResultReceiver]
    
    /// StorageCleanerResultReceivers init
    /// - Parameter delegates: Backing recivers to report the cleaner result to
    public init(delegates: [StorageCleanerResultReceiver]) {
        self.delegates = delegates
    }
    
    /// StorageCleanerResultReceivers  variadic init
    /// - Parameter delegates: Backing recivers to report the cleaner result to
    public init(_ delegates: StorageCleanerResultReceiver?...) {
        self.delegates = delegates.compactMap { $0 }
    }
    
    public func receive(_ result: ItemRemovalResult) {
        delegates.forEach {
            $0.receive(result)
        }
    }
}



