//
//  PTHomeViewController.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/19.
//  Copyright © 2018 johnson. All rights reserved.
//

import UIKit

class PTHomeViewController: PTBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "首页"
        navigationController?.JYLineColor(lineColor: UIColor.red)
        
        
        
        
    }
    
    
    @IBAction func borrowAction(_ sender: UIButton) {
        
        let demo = PTDemoViewController()

        navigationController?.JYPushViewController(demo, animated: true)
    }
}
