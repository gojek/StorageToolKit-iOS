//
//  PerformanceTracker.swift
//  
//
//  Created by Amit Samant on 07/11/22.
//

import Foundation

/// Represents requirement for tracking performance
public protocol PerformanceTracker {
    /// Marks starts of execution of a task to be measured
    /// - Parameter identifier: unique identifier for the task
    func startMeasuring(identifier: String)
    /// Marks end of execution of a task to be measured
    /// - Parameter identifier: unique identifier for the task
    func stopMeasuring(identifier: String)
    /// Add attributes associated to a particular task
    /// - Parameters:
    ///   - identifier: unique identifier for the task
    ///   - attributes: attributes hashmap
    func addAttributes(identifier: String, attributes: [String: String])
    /// Adds metrics associated to a particular task
    /// - Parameters:
    ///   - identifier: unique identifier for the task
    ///   - attributes: attributes hashmap
    func addMetrics(identifier: String, metrics: [String: Int64])
}
