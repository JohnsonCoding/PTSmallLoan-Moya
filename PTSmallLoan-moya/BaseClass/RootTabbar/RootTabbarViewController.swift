//
//  RootTabbarViewController.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/19.
//  Copyright © 2018 johnson. All rights reserved.
//

import UIKit

class RootTabbarViewController: UITabBarController {
    
    let tabbarView = RootTabbar()
    private let home = PTHomeViewController()//"首页"
    private let refund = PTRefundViewController()//"还款"
    private let approve = PTApproveViewController()//"认证"
    private let mine = PTMineViewController()//"我的"
    private let imageNormalArr = ["产品未点中","借钱未点中","认证未点中","我的未点中"]
    private let imageSeletedArr = ["产品点中","借钱点中","认证点击中","我的点击中"]
    private let titleArr = ["首页","还款","认证","我的"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navRootVCArr = [home, refund, approve, mine]
        var navArr = [PTBaseNavigationController]()
        for i in 0..<navRootVCArr.count {
            let nav = PTBaseNavigationController(rootViewController: navRootVCArr[i])
            navArr.append(nav)
        }
        
        viewControllers = navArr
        tabBar.barTintColor = UIColor.white
        tabBar.isTranslucent = false
        tabbarView.configTabbar(color: UIColor.Hex(with: "fb9704"), tabbar: self.tabBar, imageNormalArr: imageNormalArr, imageSeletedArr: imageSeletedArr, titleArr: titleArr)
        
        
    }
    
}
