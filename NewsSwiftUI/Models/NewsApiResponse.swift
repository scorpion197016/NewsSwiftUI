//
//  NewsApiResponse.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 03.08.2022.
//

import Foundation

struct NewsAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
}
