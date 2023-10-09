//
//  ThemeModifier.swift
//  Theme
//
//  Created by Praveen Prabhakar on 11/09/22.
//

import SwiftUI

/// A modifier that you apply to a view or another view modifier, producing a
/// different version of the original value.
///
/// The example below combines several modifiers to create a new modifier
/// that you can use to create blue text in 'title' font:
///
///     struct ContentView: View {
///         var body: some View {
///             Text("Downtown Bus")
///                 .font(.title)
///                 .foregroundColor(Color.blue)
///                 .backgroundColor(Color.blue)
///         }
///     }
///
/// Instead, you can then apply the theme style to any view, similar to this:
///
///     Text("Downtown Bus")
///         .style("styleName")
///
/// This shows the Text View: "Downtown Bus", using custom a modifier, renders the
/// text in blue text with "Title" font.
/// 
public struct ThemeModifier: ViewModifier {
    let name: String
    let viewState: ViewState

    @State private var themeStyle: ThemeModel.UserStyle?

    public func body(content: Content) -> some View {
        let value = "\(name)\(viewState.value)"
        DispatchQueue.main.async {
            themeStyle = ThemesManager.style(value)
        }
        let backGroundStyle = themeStyle?.background
        return content
            .theme(themeStyle?.font)
            .theme(.foreground(color: themeStyle?.forground))
            .theme(.background(color: backGroundStyle?.color, ignoreSafeArea: backGroundStyle?.ignoringSafeArea))
            .theme(themeStyle?.border)

    }
}

public extension View {
/// Call this function to set the style for the elements by using the current body
/// of the caller that will have the modifier applied to it.
/// - Parameters:
///   - name: StyleName for the element
/// - Returns: Modified ``View`` that incorporates the view modifier.
    func style(_ name: String, viewState: ViewState = .normal) -> some View {
        modifier(ThemeModifier(name: name, viewState: viewState))
    }
}
