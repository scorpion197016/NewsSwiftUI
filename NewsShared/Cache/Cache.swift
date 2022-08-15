//
//  Cache.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 08.08.2022.
//

import Foundation

protocol Cache: Actor {
    associatedtype V
    var expirationInterval: TimeInterval { get }
    func setValue(_ value: V?, forKey key: String)
    func value(forKey key: String) -> V?
    
    func removeValue(forKey key: String)
    func removeAllValues()
}
