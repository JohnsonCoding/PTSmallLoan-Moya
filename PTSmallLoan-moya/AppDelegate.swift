//
//  AppDelegate.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/19.
//  Copyright © 2018 johnson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?

}

extension AppDelegate : UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow.init(frame: kDeviceScreen)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = RootTabbarViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
