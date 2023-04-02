//
//  BorderStyleModifier.swift
//  Core
//
//  Created by Praveen Prabhakar on 28/03/23.
//

import SwiftUI

struct BorderStyleModifier: ViewModifier {
	var style: ThemeStyleModel.StyleBorder?

	func body(content: Content) -> some View {
		if style != nil {
			let shape = generateShape()
			if let color, let thickness {
				content
					.background(shape.stroke(color, lineWidth: thickness))
					.clipShape(shape)
			} else {
				content
					.clipShape(shape)
			}
		} else {
			content
		}
	}
}

extension View {
	/// Call this function to set the clip style
	/// - Parameters:
	///   - style: ``ThemeModel.StyleBorder`` value from themes
	/// - Returns: Modified ``View`` that incorporates the view modifier.
	func borderStyle(_ borderStyle: ThemeStyleModel.StyleBorder?) -> some View {
		modifier(BorderStyleModifier(style: borderStyle))
	}
}

private extension BorderStyleModifier {
	var radius: CGFloat {
		let value = style?.radius?.first { $0 > 0.0 }
		return CGFloat(value ?? 0.0)
	}

	var corners: UIRectCorner {
		guard let radiusList = style?.radius, radiusList.count == 4 else {
			return .allCorners
		}
		var corners = [UIRectCorner]()
		if radiusList[0] > 0.0 {
			corners.append(.topLeft)
		}
		if radiusList[1] > 0.0 {
			corners.append(.topRight)
		}
		if radiusList[2] > 0.0 {
			corners.append(.bottomLeft)
		}
		if radiusList[3] > 0.0 {
			corners.append(.bottomRight)
		}
		return UIRectCorner(corners)
	}

	var thickness: CGFloat? {
		guard let thickness = style?.thickness else {
			return nil
		}
		return CGFloat(thickness)
	}

	var color: Color? {
		guard let color = style?.borderColor else {
			return nil
		}
		return color
	}

	func generateShape() -> BezierPathShape {
		BezierPathShape(radius: radius, corners: corners)
	}
}

// MARK: Preview

struct BorderStyleModifier_Previews: PreviewProvider {
	static let cancelStyle: ThemeStyleModel.StyleBorder = {
		var syle = ThemeStyleModel.StyleBorder()
		syle.radius = [10]
		syle.color = "#B41818"
		syle.thickness = 2
		return syle
	}()

	static let doneStyle: ThemeStyleModel.StyleBorder = {
		var syle = ThemeStyleModel.StyleBorder()
		syle.radius = [10]
		syle.color = "#0053C2"
		syle.thickness = 2
		return syle
	}()

	static var previews: some View {
		HStack {
			Button("Cancel") {
				print("")
			}.padding()
				.theme(.background(color: .init(.white, dark: .blue), ignoreSafeArea: false))
				.borderStyle(cancelStyle)

			Button("Done") {
				print("")
			}.padding()
				.theme(.background(color: .init(.blue, dark: .red), ignoreSafeArea: false))
				.borderStyle(doneStyle)
		}
	}
}
