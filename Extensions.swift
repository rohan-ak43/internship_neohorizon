//
//  Extensions.swift
//  DynamicIslandDemoProject
//

import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}

// MARK: - Color Extensions
extension Color {
    static let customBlue = Color(red: 0.0, green: 0.48, blue: 1.0)
    static let customGreen = Color(red: 0.2, green: 0.78, blue: 0.35)
    static let customRed = Color(red: 1.0, green: 0.23, blue: 0.19)
}

// MARK: - View Extensions
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
