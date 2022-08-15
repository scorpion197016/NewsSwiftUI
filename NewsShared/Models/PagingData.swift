//
//  PagingData.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 15.08.2022.
//

import Foundation

actor PagingData {
    private(set) var currentPage = 0
    private(set) var hasReachedEnd = false
    
    let itemsPerPage: Int
    let maxPageLimit: Int
    
    init(itemsPerPage: Int, maxPageLimit: Int) {
        assert(itemsPerPage > 0 && maxPageLimit > 0, "Items per page and max page limit must be greater than zero")
        
        self.maxPageLimit = maxPageLimit
        self.itemsPerPage = itemsPerPage
    }
    
    var nextPage: Int { currentPage + 1 }
    var shouldLoadNextPage: Bool {
        !hasReachedEnd && nextPage <= maxPageLimit
    }
    
    func loadNextPage<T>(dataFetchProvider: @escaping (Int) async throws -> [T]) async throws -> [T] {
        if Task.isCancelled { return [] }
        print("PAGING: Current Page \(currentPage), next page: \(nextPage)")
        
        guard shouldLoadNextPage else {
            print("PAGING: Stop loading next page. Has Reached end: \(hasReachedEnd), next page: \(nextPage), max page limit: \(maxPageLimit)")
            return []
        }
        
        let nextPage = self.nextPage
        let items = try await dataFetchProvider(nextPage)
        
        if Task.isCancelled || nextPage != self.nextPage { return [] }
        
        currentPage = nextPage
        hasReachedEnd = items.count < itemsPerPage
        
        print("PAGING: fetch \(items.count) items(s) successfully. Current Page: \(currentPage)")
        
        return items
    }
    
    func reset() {
        currentPage = 0
        hasReachedEnd = false
    }
}
