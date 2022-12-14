//
//  NewsMacOSApp.swift
//  NewsMacOS
//
//  Created by nikita9x on 16.08.2022.
//

import SwiftUI
import Foundation

class AppDelegate: NSObject, NSApplicationDelegate {
    func application(_ application: NSApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([NSUserActivityRestoring]) -> Void) -> Bool {
        if let urlString = userActivity.userInfo?[activityURLKey] as? String,
           let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        }
        return true
    }
}

@main
struct NewsMacOSApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject private var bookmarkVM: ArticleBookmarkViewModel = ArticleBookmarkViewModel.shared
    @StateObject private var searchVM: ArticleSearchViewModel = ArticleSearchViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkVM)
                .environmentObject(searchVM)
        }
        .commands {
            SidebarCommands()
            NewsCommands()
        }
        
        Settings {
            SettingsView()
                .environmentObject(searchVM)
                .environmentObject(bookmarkVM)
        }
    }
}
