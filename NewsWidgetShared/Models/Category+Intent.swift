//
//  Category+Intent.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 16.08.2022.
//

import Foundation

extension Category {
    init (_ categoryIntentParam: CategoryIntentParam) {
        switch categoryIntentParam {
            case .general: self = .general
            case .business: self = .business
            case .entertainment: self = .entertainment
            case .health: self = .health
            case .science: self = .science
            case .sports: self = .sports
            case .technology: self = .technology
            case .unknown: self = .general
        }
    }
}
