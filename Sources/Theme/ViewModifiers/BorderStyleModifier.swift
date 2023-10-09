//
//  BorderStyleModifier.swift
//  Theme
//
//  Created by Praveen Prabhakar on 28/03/23.
//

import SwiftUI

struct BorderStyleModifier: ViewModifier {
	var style: ThemeJSONStructure.StyleBorder?

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
	///   - style: ``ThemeStructure.StyleBorder`` value from themes
	/// - Returns: Modified ``View`` that incorporates the view modifier.
	func borderStyle(_ borderStyle: ThemeJSONStructure.StyleBorder?) -> some View {
		modifier(BorderStyleModifier(style: borderStyle))
	}
}

private extension BorderStyleModifier {
    var radius: CGFloat {
        let value = style?.radius?.first { $0 > 0.0 }
        return CGFloat(value ?? 0.0)
    }

    var corners: RectCorner {
        guard let radiusList = style?.radius, radiusList.count == 4 else {
            return .allCorners
        }
        var corners = [RectCorner]()
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
        return RectCorner(corners)
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
	static let cancelStyle: ThemeJSONStructure.StyleBorder = {
		var syle = ThemeJSONStructure.StyleBorder()
		syle.radius = [8]
		syle.color = "#EE2C4A"
		syle.thickness = 20
		return syle
	}()

	static let doneStyle: ThemeJSONStructure.StyleBorder = {
		var syle = ThemeJSONStructure.StyleBorder()
		syle.radius = [10]
		syle.color = "#F9DAE0"
		syle.thickness = 200
		return syle
	}()

	static var previews: some View {
		HStack {
			Button("Cancel") {
				print("")
			}.padding()
				.theme(.background(color: .init(.yellow, dark: .blue)))
				.borderStyle(cancelStyle)

			Button("Done") {
				print("")
			}.padding()
				.borderStyle(doneStyle)
		}
	}
}
