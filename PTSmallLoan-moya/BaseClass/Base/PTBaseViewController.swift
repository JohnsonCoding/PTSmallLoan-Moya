//
//  PTBaseViewController.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/20.
//  Copyright © 2018 johnson. All rights reserved.
//

import UIKit

class PTBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.jy_F5F5F5
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if ((self.navigationController?.interactivePopGestureRecognizer) != nil)  {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        
    }

}
