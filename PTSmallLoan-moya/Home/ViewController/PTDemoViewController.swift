//
//  PTDemoViewController.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/21.
//  Copyright © 2018 johnson. All rights reserved.
//

import UIKit

class PTDemoViewController: PTBaseViewController {
    
    var dataModel: PTLoginModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        NetWorkRequest(.login(mobile: "13458301707", password: "12345678"), completion: {[weak self] (response) -> (Void) in

            if let model = PTLoginModel.deserialize(from: response, designatedPath: RESPONSE_RESULT) {
                print("----------\(model.org_name ?? "")")

                self?.dataModel = model
                self?.title = model.name
            }
            
            self?.navigationController?.popViewController(animated: true)
        }, failed: { (message) -> (Void) in
            

            JYTool().showAlertView(self, title: "这是个标题", message: message, cancelButtonTitle: "取消", otherButtonTitle: "确定", confirm: {
                print("gannima")
            }, cancle: {
                print("qvnimade")
            })
            
            
        })
    }
    

    

}
