//
//  ArticleWidgetModel.swift
//  NewsMacOS
//
//  Created by nikita9x on 16.08.2022.
//

import Foundation

struct ArticleWidgetModel: Identifiable {
    
    enum State {
        case placeholder
        case article(article: Article, imageData: Data?)
    }
    
    let state: State
    
    var id: UUID {
        switch state {
            case .placeholder:
                return UUID()
            case .article(let article, _):
                return article.id
        }
    }
    
    var title: String {
        switch state {
            case .placeholder:
                return "Placeholder widget text"
            case .article(let article, _):
                return article.title
        }
    }
    
    var subtitle: String {
        switch state {
            case .placeholder:
                return "Placeholder widget text"
            case .article(let article, _):
                return article.descriptionText
        }
    }
    
    var url: URL {
        switch state {
            case .placeholder:
                return URL(string: "app://home")!
            case .article(let article, _):
                return article.articleURL
        }
    }
    
    var isPlaceholder: Bool {
        if case .placeholder = state {
            return true
        }
        return false
    }
    
    var article: Article? {
        if case .article(let article, _) = state {
            return article
        }
        return nil
    }
    
    var imageData: Data? {
        if case .article(_, let imageData) = state {
            return imageData
        }
        return nil
    }
}
