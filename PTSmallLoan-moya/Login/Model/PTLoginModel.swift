//
//  PTLoginModel.swift
//  PTSmallLoan-moya
//
//  Created by 江勇 on 2018/12/26.
//  Copyright © 2018 johnson. All rights reserved.
//

import Foundation
import HandyJSON

class PTLoginModel: HandyJSON{
    var user_id:  String?
    var mobile: String?
    var mobile_hide: String?
    var name: String?
    var avator: String?
    var user_type: String?
    var org_name: String?
    
    //用HandyJSON必须要实现这个方法
    required init() {}
}
