//
//  NewsApi.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 03.08.2022.
//

import Foundation

struct NewsApi {
    static let shared = NewsApi()
    
    private init() {}
    private let session = URLSession.shared
    private let apikey = "49ef4455cdbf4a2d93f684a6279d5b35"
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from category: Category, page: Int = 1, pageSize: Int = 20) async throws -> [Article] {
        try await fetchArticles(from: generateNewsURL(from: category, page: page, pageSize: pageSize))
    }
    
    func search(for query: String) async throws -> [Article] {
        try await fetchArticles(from: generateSearchURL(from: query))
    }
    
    func fetchAllCategoriesArticles() async throws -> [CategoryArticles] {
        try await withThrowingTaskGroup(of: Result<CategoryArticles, Error>.self) { group in
            for category in Category.allCases {
                group.addTask {
                    await fetchResults(from: category)
                }
            }
            
            var results = [Result<CategoryArticles, Error>]()
            for try await result in group {
                results.append(result)
            }
            
            if let first = results.first,
               case .failure(let error) = first,
               (error as NSError).code == 401 {
                throw error
            }
            
            var categories = [CategoryArticles]()
            for result in results {
                if case .success(let value) = result {
                    categories.append(value)
                }
            }
            
            categories.sort { $0.category.sortIndex < $1.category.sortIndex }
            return categories
        }
    }
    
    private func fetchResults(from category: Category) async -> Result<CategoryArticles, Error> {
        do {
            let articles = try await fetchArticles(from: generateNewsURL(from: category))
            return .success(CategoryArticles(category: category, articles: articles))
        } catch {
            return .failure(error)
        }
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
                
            case (200...299), (400...499):
                let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
                if apiResponse.status == "ok" {
                    return apiResponse.articles ?? []
                } else {
                    throw generateError(description: apiResponse.message ?? "An error occured")
                }
            default:
                throw generateError(description: "A server error occured")
        }
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    
    private func generateSearchURL(from query: String) -> URL {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var url = "https://newsapi.org/v2/everything?"
        url += "apikey=\(apikey)"
        url += "&language=en"
        url += "&q=\(percentEncodedString)"
        return URL(string: url)!
    }
    
    private func generateNewsURL(from category: Category, page: Int = 1, pageSize: Int = 20) -> URL {
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apikey)"
        url += "&language=en"
        url += "&category=\(category.rawValue)"
        url += "&page=\(page)"
        url += "&pageSize=\(pageSize)"
        return URL(string: url)!
    }
}
