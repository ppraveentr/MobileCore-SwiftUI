//
//  FontModifier.swift
//  Theme
//
//  Created by Praveen Prabhakar on 12/09/22.
//

import SwiftUI

public struct FontModifier: ViewModifier {
    let themeValue: ColorSchemeValue<Font>?
    @Environment(\.colorScheme) var colorScheme

    public init(themeValue: ColorSchemeValue<Font>?) {
        self.themeValue = themeValue
    }

    public func body(content: Content) -> some View {
        Group {
            if themeValue != nil {
                content.font(themeValue?.value(colorScheme))
            } else {
                content
            }
        }
    }
}

public extension View {
/// Call this function to set the Color's based on ``ColorSchemeValue``
/// - Parameters:
///   - name: Configured `ligh` and `dark` mode value for `Font`
/// - Returns: Modified ``View`` that incorporates the view modifier.
    func theme(_ font: ColorSchemeValue<Font>?) -> some View {
        modifier(FontModifier(themeValue: font))
    }
}
