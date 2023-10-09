//
//  ViewState.swift
//  Theme
//
//  Created by Praveen Prabhakar on 19/05/23.
//

import SwiftUI

public
protocol ObservableViewState: ObservableObject {
    var state: ViewState { get }
    func loadView()
}

public enum ViewState: String {
    case normal, disabled, highlighted, selected
    case idle, loaded

    var value: String {
        self == .normal ? "" : ":\(self.rawValue)"
    }
}
