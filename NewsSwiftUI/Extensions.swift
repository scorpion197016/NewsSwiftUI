//
//  Extensions.swift
//  NewsSwiftUI
//
//  Created by nikita9x on 04.08.2022.
//

import Foundation
import SwiftUI

extension View {
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}
