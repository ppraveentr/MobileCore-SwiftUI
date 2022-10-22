//
//  ThemeModifier.swift
//  Theme
//
//  Created by Praveen Prabhakar on 11/09/22.
//

import Core
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
///         }
///     }
///
/// Instead, you can then apply the theme style to any view, similar to this:
///
///     Text("Downtown Bus")
///         .style("styleName")
///
/// This shows the Text View: "Downtown Bus", using custom a modifier, renders the
/// text in blue text with "Titlte" font.
/// 
public struct ThemeModifier: ViewModifier {
    let name: String

    @State private var themeStyle: ThemeModel.UserStyle?

    public func body(content: Content) -> some View {
        DispatchQueue.main.async { themeStyle = ThemesManager.style(name) }
        return content
            .theme(themeStyle?.font)
            .theme(.foregroundColor(color: themeStyle?.forgroundColor))
    }
}

public extension View {
/// Call this function to set the style for the elements by using the current body
/// of the caller that will have the modifier applied to it.
/// - Parameters:
///   - name: StyleName for the element
/// - Returns: Modified ``View`` that incorporates the view modifier.
    func style(_ name: String) -> some View {
        modifier(ThemeModifier(name: name))
    }
}
