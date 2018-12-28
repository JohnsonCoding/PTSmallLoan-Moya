//
//  SMacro.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/19.
//  Copyright © 2018 johnson. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

//let CustomDateFormat = CustomDateFormatTransform(formatString: "yyyy-MM-dd HH:mm:ss")

// MARK: -- 字体大小
let Font12 = UIFont.systemFont(ofSize: 12)
let Font13 = UIFont.systemFont(ofSize: 13)
let Font14 = UIFont.systemFont(ofSize: 14)
let Font15 = UIFont.systemFont(ofSize: 15)
let Font16 = UIFont.systemFont(ofSize: 16)
let Font17 = UIFont.systemFont(ofSize: 17)
let Font18 = UIFont.systemFont(ofSize: 18)

// MARK: -- 获取控制器视图
let JYWindow = UIApplication.shared.keyWindow?.rootViewController
// MARK: -- 设备尺寸
let kDeviceScreen = UIScreen.main.bounds
var kDeviceWidth: CGFloat {
    return kDeviceScreen.size.width
}
var kDeviceHeight: CGFloat {
    return kDeviceScreen.size.height
}
let KstatuesBarH = 20.0 as CGFloat
let kNavBarHeight = 64.0 as CGFloat
let kTabBarHeight = 49.0 as CGFloat
let kRatio16To9 = 9.0/16.0 as CGFloat

// MARK: -- 自定义运算符
postfix operator ===       //Int 转 String
postfix func ===(optional: Int?) ->String {
    if let value = optional {
        return String(describing: value)
    }
    return ""
}


// MARK: -- 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况, 用get方法是因为这样才会在获取isNetworkConnect时实时判断网络链接请求
var isNetworkConnect: Bool {
    get{
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true //无返回就默认网络已连接
    }
}
/**
 *  block
 */

typealias CommonSimpleClosure = @convention(block) () -> Void
typealias CommonStringClosure = @convention(block) (String) -> Void
typealias CommonArrayClosure = @convention(block) ([AnyObject]) -> Void
typealias CommonDictionaryClosure = @convention(block) ([NSObject : AnyObject]) -> Void

/**
 *  ratio
 */

func Ratio375(args: CGFloat) -> CGFloat {
    return args/375.0*kDeviceWidth
}

/**
 *  folder
 */

let DOCUMENT_FOLDER = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

let LIBRARY_FOLDER = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!


/**
 *  font
 */

func kFont(args: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: args)
}

func kBoldFont(args: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: args)
}

func CustomParagraph(lineSpacing: CGFloat, lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> NSMutableParagraphStyle {
    let paragraph = NSMutableParagraphStyle()
    paragraph.lineSpacing = lineSpacing
    paragraph.lineBreakMode = lineBreakMode
    return paragraph
}

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

let isIPad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad




