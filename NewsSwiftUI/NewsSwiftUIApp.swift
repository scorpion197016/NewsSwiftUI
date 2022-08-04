//
//  NewsSwiftUIApp.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 03.08.2022.
//

import SwiftUI

@main
struct NewsSwiftUIApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
