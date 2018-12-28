//
//  UIDevice+JY.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/21.
//  Copyright © 2018 johnson. All rights reserved.
//

import UIKit

extension UIDevice {
    
   static var jy_systemVersion:String{//系统版本
        return UIDevice.current.systemVersion
    }
   static var jy_systemName:String{//设备名称
        return UIDevice.current.systemName
    }
   static var jy_phoneType:String{//设备型号
        return UIDevice.current.model
    }
    
}
