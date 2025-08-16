//
//  Subsystem.swift
//  SmartLogging
//
//  Created by Alex.personal on 9/8/25.
//
import Foundation

public protocol Subsystem {
    var name: String { get }
    var category: Category { get }
}
