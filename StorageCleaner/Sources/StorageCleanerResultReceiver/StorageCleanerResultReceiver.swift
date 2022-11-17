//
//  StorageCleanerResultReceiver.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Protocol representing the cleaner result receiver
public protocol StorageCleanerResultReceiver {
    func receive(_ result: ItemRemovalResult)
}
