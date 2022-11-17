//
//  Cleaner.swift
//  StorageCleaner
//
//  Created by Amit Samant on 17/02/22.
//

import Foundation

/// Cleaner is responsible for get the removable files from provided enevelop and clean the envelop
///
/// The name of this class was supposed to be StorageCleaner due to issue in Swift compiler which raise name collision we had to change it
///  https://developer.apple.com/forums/thread/690881
///  https://github.com/apple/swift/issues/43510
public final class Cleaner {
    
    /// Envelope to get the removable files from
    private var envelope: StorageEnvelope
    /// Receiver to send the removal results to
    private var receiver: StorageCleanerResultReceiver
    
    public init(envelope: StorageEnvelope, receiver: StorageCleanerResultReceiver) {
        self.envelope = envelope
        self.receiver = receiver
    }
    
    /// Cleans the fetched removable files
    public func clean() {
        let items = envelope.findRemovableItems()
        let result = items.remove()
        receiver.receive(result)
    }
}
