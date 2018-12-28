//
//  UIColor+JY.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/19.
//  Copyright © 2018 johnson. All rights reserved.
//
import UIKit

extension UIColor {
    static let jy_F5F5F5 = UIColor.Hex(with: "#F5F5F5")  //所有页面背景色
    static let jy_FAFAFA = UIColor.Hex(with: "#FAFAFA")  //导航栏灰色
    static let jy_F9AD35 = UIColor.Hex(with: "#F9AD35")  //主体颜色，黄色
    static let jy_333333 = UIColor.Hex(with: "#333333")
    static let jy_666666 = UIColor.Hex(with: "#666666")
    static let jy_999999 = UIColor.Hex(with: "#999999")
    static let jy_F2F2F2 = UIColor.Hex(with: "#F2F2F2")
    static let jy_3388E0 = UIColor.Hex(with: "#3388E0")
    static let jy_4D4D4D = UIColor.Hex(with: "#4D4D4D")
    static let jy_B3B3B3 = UIColor.Hex(with: "#B3B3B3")
    static let jy_1480CC = UIColor.Hex(with: "#1480CC")
    static let jy_4F8FE1 = UIColor.Hex(with: "#4F8FE1")
    static let jy_5D8CE1 = UIColor.Hex(with: "#5D8CE1")
    static let jy_E1E1E1 = UIColor.Hex(with: "#E1E1E1")
    static let jy_E8E8E8 = UIColor.Hex(with: "#E8E8E8")

}

extension UIColor {
    
    static func Hex(with hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var rgb: CUnsignedInt = 0
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        scanner.scanHexInt32(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let b = CGFloat((rgb & 0xFF)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
}


