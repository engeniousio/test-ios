//
//  UIColor+hex.swift
//  engenious-challenge
//
//  Created by Sergii Tkachenko on 28.05.2022.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255.0
                    g = CGFloat((hexNumber & 0x00ff00) >> 8)  / 255.0
                    b = CGFloat(hexNumber  & 0x0000ff) / 255.0
                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            } else if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255.0
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255.0
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8)  / 255.0
                    a = CGFloat(hexNumber  & 0x000000ff) / 255.0
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
    
    var hexValue: String {
        var color = self
        if color.cgColor.numberOfComponents < 4 {
            let c = color.cgColor.components!
            color = UIColor(red: c[0], green: c[0], blue: c[0], alpha: c[1])
        }
        if color.cgColor.colorSpace!.model != .rgb {
            return "#FFFFFF"
        }
        let components = color.cgColor.components!
        return String(format: "#%02X%02X%02X",
                      Int(components[0] * 255.0),
                      Int(components[1] * 255.0),
                      Int(components[2] * 255.0))
    }
}
