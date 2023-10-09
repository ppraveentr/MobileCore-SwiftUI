//
//  ColorSchemeValue.swift
//  Theme
//
//  Created by Praveen Prabhakar on 16/09/22.
//

import Foundation
import SwiftUI

public struct ColorSchemeValue<T> {
    public var light: T, dark: T?
    var optionalDark: T { dark ?? light }

    public init(_ light: T, dark: T? = nil) {
        self.light = light
        self.dark = dark
    }

    public func value(_ colorScheme: ColorScheme) -> T {
        colorScheme == .light ? light : optionalDark
    }
}
