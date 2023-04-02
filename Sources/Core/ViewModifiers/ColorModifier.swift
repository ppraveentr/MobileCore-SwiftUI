//
//  ColorModifier.swift
//  Core
//
//  Created by Praveen Prabhakar on 11/09/22.
//

import SwiftUI

public enum ColorModifierStyle {
    case foreground(color: ColorSchemeValue<Color>?)
    case background(color: ColorSchemeValue<Color>?)

    func value(_ colorScheme: ColorScheme) -> Color? {
        switch self {
        case let .foreground(color):
            return color?.value(colorScheme)
        case let .background(color):
            return color?.value(colorScheme)
        }
    }
}

public struct ColorModifier: ViewModifier {
    let themeValue: ColorModifierStyle
    @Environment(\.colorScheme) var colorScheme

    public init(themeValue: ColorModifierStyle) {
        self.themeValue = themeValue
    }

    public func body(content: Content) -> some View {
        Group {
            let color = themeValue.value(colorScheme)
            switch themeValue {
            case .foreground where color != nil:
                content.foregroundColor(color)
            case .background where color != nil:
                content.background(color)
            default:
                content
            }
        }
    }
}

public extension View {
/// Call this function to set the Color's based on ``ColorModifierStyle`` enum
/// - Parameters:
///   - name: Configured ``ColorModifierStyle`` with ``ColorSchemeValue`` color
/// - Returns: Modified ``View`` that incorporates modifier.
    func theme(_ color: ColorModifierStyle) -> some View {
        modifier(ColorModifier(themeValue: color))
    }
}
