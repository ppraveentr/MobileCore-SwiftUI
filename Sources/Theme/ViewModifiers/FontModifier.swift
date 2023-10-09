//
//  FontModifier.swift
//  Theme
//
//  Created by Praveen Prabhakar on 12/09/22.
//

import SwiftUI

public struct FontModifier: ViewModifier {
    let themeValue: Appearance<Font>?
    @Environment(\.colorScheme) var colorScheme

    public init(themeValue: Appearance<Font>?) {
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
/// Call this function to set the Color's based on ``Appearance``
/// - Parameters:
///   - name: Configured `ligh` and `dark` mode value for `Font`
/// - Returns: Modified ``View`` that incorporates the view modifier.
    func theme(_ font: Appearance<Font>?) -> some View {
        modifier(FontModifier(themeValue: font))
    }
}

// MARK: Preview

struct FontModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("""
Sample Text Font:
            headline in Light-Mode
            caption in Dark-Mode
""")
            .theme(.init(Font.headline, dark: Font.caption))
    }
}
