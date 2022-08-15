//
//  CacheEntry.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 08.08.2022.
//

import Foundation

final class CacheEntry<V> {
    let key: String
    let value: V
    let expiredTimestamp: Date
    
    init(key: String, value: V, expiredTimestamp: Date) {
        self.key = key
        self.value = value
        self.expiredTimestamp = expiredTimestamp
    }
    
    func isCacheExpired(after date: Date = .now) -> Bool {
        date > expiredTimestamp
    }
}

extension CacheEntry: Codable where V: Codable {}
