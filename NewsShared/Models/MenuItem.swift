//
//  MenuItem.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 04.08.2022.
//

import Foundation

enum MenuItem: CaseIterable {
case search
case saved
case category(Category)
    
    var text: String {
        switch self {
            case .search:
                return "Search"
            case .saved:
                return "Saved"
            case .category(let category):
                return category.text
        }
    }
    
    var systemImageName: String {
        switch self {
            case .search:
                return "magnifyingglass"
            case .saved:
                return "bookmark"
            case .category(let category):
                return category.systemImage
        }
    }
    
    static var allCases: [MenuItem] {
        return [.search, .saved] + Category.menuItems
    }
}

extension MenuItem: Identifiable {
    var id: String {
        switch self {
            case .search:
                return "search"
            case .saved:
                return "saved"
            case .category(let category):
                return category.rawValue
        }
    }
    
    init?(id: MenuItem.ID?) {
        switch id {
            case MenuItem.search.id:
                self = .search
            case MenuItem.saved.id:
                self = .saved
            default:
                if let id = id, let category = Category(rawValue: id) {
                    self = .category(category)
                } else {
                    return nil
                }
        }
    }
}
