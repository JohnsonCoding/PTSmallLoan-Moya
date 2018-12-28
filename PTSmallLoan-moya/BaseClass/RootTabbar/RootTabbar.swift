//
//  RootTabbar.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/19.
//  Copyright © 2018 johnson. All rights reserved.
//

import UIKit
// MARK: -- 设置tabbar样式
class RootTabbar: NSObject {
    
    func configTabbar(color: UIColor, tabbar: UITabBar, imageNormalArr: [String], imageSeletedArr: [String], titleArr: [String]) {
        var count: Int = 0
        tabbar.tintColor = color
        if let items = tabbar.items {
            for item in items {
                var normalImage: UIImage = UIImage(named: imageNormalArr[count]) ?? UIImage()
                var seletedImage: UIImage = UIImage(named: imageSeletedArr[count]) ?? UIImage()
                normalImage = normalImage.withRenderingMode(.alwaysOriginal)
                seletedImage = seletedImage.withRenderingMode(.alwaysOriginal)
                item.image = normalImage
                item.selectedImage = seletedImage
                item.title = titleArr[count]
                count += 1
            }
        }
    }
}
