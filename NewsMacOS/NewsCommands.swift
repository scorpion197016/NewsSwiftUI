//
//  NewsCommands.swift
//  NewsMacOS
//
//  Created by nikita9x on 16.08.2022.
//

import Foundation
import SwiftUI

struct NewsCommands: Commands {
    var body: some Commands {
        CommandGroup(before: .sidebar) {
            BodyView()
                .keyboardShortcut("R", modifiers: [.command])
        }
    }
    
    struct BodyView: View {
        @FocusedValue(\.refreshAction) private var refreshAction: (() -> Void)?
        
        var body: some View {
            Button("Refresh News") {
                refreshAction?()
            }
        }
    }
}
