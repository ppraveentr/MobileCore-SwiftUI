//
//  ViewState.swift
//  Core
//
//  Created by Praveen Prabhakar on 19/05/23.
//

import SwiftUI

public
protocol ObservableViewState: ObservableObject {
	var state: ViewState { get }
	func loadView()
}

// swiftlint:disable missing_docs
public enum ViewState {
	case idle, loaded
}
// swiftlint:enable missing_docs
