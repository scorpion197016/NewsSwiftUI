//
//  NewsMacOSWidget.swift
//  NewsMacOSWidget
//
//  Created by nikita9x on 16.08.2022.
//

import WidgetKit
import SwiftUI
import Intents


@main
struct NewsMacOSWidget: Widget {
    let kind: String = "NewsMacWidget"

        var body: some WidgetConfiguration {
            IntentConfiguration(kind: kind, intent: SelectCategoryIntent.self, provider: ArticleProvider()) { entry in
                ArticleEntryWidgetView(entry: entry)
            }
            .configurationDisplayName("My Widget")
            .description("This is an example widget.")
        }
}
