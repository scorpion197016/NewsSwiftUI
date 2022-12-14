//
//  KeysTracker.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 08.08.2022.
//

import Foundation

final class KeysTracker<V>: NSObject, NSCacheDelegate {
    var keys = Set<String>()
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        guard let entry = obj as? CacheEntry<V> else {
            return
        }
        
        keys.remove(entry.key)
    }
}
