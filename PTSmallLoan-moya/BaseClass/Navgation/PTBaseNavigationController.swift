//
//  PTBaseNavigationController.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/21.
//  Copyright © 2018 johnson. All rights reserved.
//

import UIKit

class PTBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationBar.setBackgroundImage(UIImage.image(with: UIColor.Hex(with: "fb9704")), for: .any, barMetrics: .default)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.Hex(with:"ffffff"), .font:Font17]
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.white
        
        navigationBar.backIndicatorImage = UIImage.init(named: "返回-白")
        navigationBar.backIndicatorTransitionMaskImage = UIImage.init(named: "返回-白")

    }
    


}
