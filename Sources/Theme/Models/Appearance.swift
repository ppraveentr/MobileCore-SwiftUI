//
//  Appearance.swift
//  Theme
//
//  Created by Praveen Prabhakar on 16/09/22.
//

import Foundation
import SwiftUI

public struct Appearance<T> {
    public var light: T
    public var dark: T?

    public init(_ light: T, dark: T? = nil) {
        self.light = light
        self.dark = dark
    }

    public func value(_ colorScheme: ColorScheme) -> T {
        colorScheme == .light ? light : optionalDark
    }

    private var optionalDark: T { dark ?? light }
}
