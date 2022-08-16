//
//  FocusedValue+RefreshAction.swift
//  NewsMacOS
//
//  Created by nikita9x on 16.08.2022.
//

import Foundation
import SwiftUI

fileprivate var _refreshAction: (() -> Void)?

extension FocusedValues {
    var refreshAction: (() -> Void)? {
        get {
            _refreshAction
        }
        set {
            _refreshAction = newValue
        }
    }
    
    struct RefreshActionKey: FocusedValueKey {
        typealias Value = () -> Void
    }
}
