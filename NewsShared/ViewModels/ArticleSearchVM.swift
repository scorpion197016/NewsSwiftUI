//
//  ArticleSearchVM.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 04.08.2022.
//

import Foundation

@MainActor
class ArticleSearchViewModel: ObservableObject {
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    @Published var history = [String]()
    private let historyDataStore = PlistDataStore<[String]>(filename: "histories")
    private let historyLimit = 10
    
    private let newsApi = NewsApi.shared
    private var trimmedSearchQuery: String {
        searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static let shared = ArticleSearchViewModel()
    private init() {
        load()
    }
    
    func addHistory(_ text: String) {
        if let index = history.firstIndex(where: {text.lowercased() == $0.lowercased()}) {
            history.remove(at: index)
        } else if history.count == historyLimit {
            history.remove(at: history.count - 1)
        }
        
        history.insert(text, at: 0)
        historiesUpdated()
    }
    
    func removeHistory(_ text: String) {
        guard let index = history.firstIndex(where: { text.lowercased() == $0.lowercased()}) else {
            return
        }
        history.remove(at: index)
        historiesUpdated()
    }
    
    func removeAllHistory() {
        history.removeAll()
        historiesUpdated()
    }
    
    func searchArticle() async {
        if Task.isCancelled { return }
        let searchQuery = trimmedSearchQuery
        phase = .empty
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsApi.search(for: searchQuery)
            if Task.isCancelled { return }
            if searchQuery != trimmedSearchQuery { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            if searchQuery != trimmedSearchQuery { return }
            phase = .failure(error)
        }
    }
    
    private func load() {
        Task {
            self.history = await historyDataStore.load() ?? []
        }
    }
    
    private func historiesUpdated() {
        let history = self.history
        Task {
            await historyDataStore.save(history)
        }
    }
}
