//
//  Colors.swift
//  GitContriGraph
//
//  Created by Shashank on 02/11/24.
//

import SwiftUI

let DarkColors: [Color] = [
    Color(hex: "161b22")!,
    Color(hex: "0e4429")!,
    Color(hex: "006d32")!,
    Color(hex: "26a641")!,
    Color(hex: "39d353")!,
]
let LightColors: [Color] = [
    Color(hex: "ebedf0")!,
    Color(hex: "9be9a8")!,
    Color(hex: "40c463")!,
    Color(hex: "30a14e")!,
    Color(hex: "216e39")!,
]

extension Color {
    init(level: ContributionLevel, colorScheme: ColorScheme) {
        let colors = colorScheme == .dark ? DarkColors : LightColors
        self.init(colors[level.toIdx()])
    }
    
    init?(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        let scanner = Scanner(string: hexString)
        
        var rgbValue: UInt64 = 0
        guard scanner.scanHexInt64(&rgbValue) else {
            return nil
        }
        
        var red, green, blue, alpha: UInt64
        switch hexString.count {
        case 6:
            red = (rgbValue >> 16)
            green = (rgbValue >> 8 & 0xFF)
            blue = (rgbValue & 0xFF)
            alpha = 255
        case 8:
            red = (rgbValue >> 16)
            green = (rgbValue >> 8 & 0xFF)
            blue = (rgbValue & 0xFF)
            alpha = rgbValue >> 24
        default:
            return nil
        }
        
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, opacity: CGFloat(alpha) / 255)
    }
}
