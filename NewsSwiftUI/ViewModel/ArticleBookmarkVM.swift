//
//  ArticleBookmarkViewModel.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 04.08.2022.
//

import Foundation

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarks: [Article] = []
    private let bookmarkStore = PlistDataStore<[Article]>(filename: "bookmarks")
    
    static let shared = ArticleBookmarkViewModel()
    private init() {
        Task {
            await load()
        }
    }
    
    private func load() async {
        bookmarks = await bookmarkStore.load() ?? []
    }
    
    func isBookmarked(for article: Article) -> Bool {
        bookmarks.first { article.id == $0.id } != nil
    }
    
    func addBookmark(for article: Article) {
        guard !isBookmarked(for: article) else {
            return
        }
        
        bookmarks.insert(article, at: 0)
        bookmarkUpdate()
    }
    
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: {$0.id == article.id}) else {
            return
        }
        
        bookmarks.remove(at: index)
        bookmarkUpdate()
    }
    
    private func bookmarkUpdate() {
        let bookmarks = self.bookmarks
        Task {
            await bookmarkStore.save(bookmarks)
        }
    }
}
