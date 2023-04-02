//
//  BezierPathShape.swift
//  Core
//
//  Created by Praveen Prabhakar on 28/03/23.
//
import SwiftUI

public struct BezierPathShape: Shape {
	public var radius = CGFloat.infinity
	public var corners = UIRectCorner.allCorners

	public func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(roundedRect: rect,
								byRoundingCorners: corners,
								cornerRadii: CGSize(width: radius, height: radius))
		return Path(path.cgPath)
	}
}
