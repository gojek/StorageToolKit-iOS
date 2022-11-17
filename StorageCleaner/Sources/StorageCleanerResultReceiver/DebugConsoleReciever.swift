//
//  DebugConsoleReciever.swift
//  StorageCleaner
//
//  Created by Amit Samant on 18/02/22.
//

import Foundation

/// DebugConsoleReciever is resposible to print the removal result info to debug console
public final class DebugConsoleReciever: StorageCleanerResultReceiver {
    public func receive(_ result: ItemRemovalResult) {
        let string = """
        Removed \(result.removedItemCount) item(s)
        worth \(result.freedSpaceInBytes))
        \(result.unremovedItemCount) failed to be removed.\n reason map: \(result.unremovedItems)
"""
        debugPrint(string)
    }
}
