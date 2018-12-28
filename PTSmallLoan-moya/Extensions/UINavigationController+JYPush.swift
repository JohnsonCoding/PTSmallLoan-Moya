//
//  UINavigationController+JYPush.swift
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/21.
//  Copyright © 2018 johnson. All rights reserved.
//

import UIKit


private var overlayKey : UIView?
private var lineKey : UIView?

extension UINavigationController {
    
    
    func JYPushViewController(_ viewcontroller: UIViewController,removeVC:Bool = false ,animated: Bool) {
        
        let backItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
        topViewController?.navigationItem.backBarButtonItem = backItem
    
        if removeVC == true {
            var viewControllers : [UIViewController] = self.viewControllers
            viewControllers.removeLast()
            viewControllers.append(viewcontroller)
            self.viewControllers = viewControllers
        }else{
            if children.count > 0 {
                viewcontroller.hidesBottomBarWhenPushed = true
            }
            self.pushViewController(viewcontroller, animated: animated)
        }
    }
    
    func JYPopToViewController(index: NSInteger, animated: Bool) {
        
        let count = viewControllers.count-index-1
        var viewController : UIViewController?
        
        if count >= 0 && count < viewControllers.count {
            viewController = viewControllers[count]
        }
        
        if let VC = viewController {
            self.popToViewController(VC, animated: true )
        }else{
            self.popToRootViewController(animated: true)
        }
    }
    
    
    private var overlay: UIView? {
        set {
            objc_setAssociatedObject(self, &overlayKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &overlayKey) as? UIView
        }
    }
    
    private var line: UIView? {
        set {
            objc_setAssociatedObject(self, &lineKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &lineKey) as? UIView
        }
    }
    
    func JYBackGroundColor(overlayColor: UIColor) {
        
        if overlay == nil {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            overlay = UIView(frame: CGRect(x: 0, y: 0, width: navigationBar.bounds.width, height: navigationBar.bounds.height+UIApplication.shared.statusBarFrame.height))
            overlay!.isUserInteractionEnabled = false
            navigationBar.subviews.first?.insertSubview(overlay!, at: 0)
            //        [self.overlay mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.right.bottom.equalTo(self.overlay.superview);
            //            make.height.equalTo(CGRectGetHeight(self.navigationBar.bounds) + CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]));
            //            }];
        }
        overlay?.backgroundColor = overlayColor
        
    }
    
    func JYLineColor(lineColor: UIColor) {
        
//        guard let line = self.line else {
//            return
//        }

        if line == nil {
            navigationBar.shadowImage = UIImage()
            line = UIView(frame: CGRect(x: 0, y: navigationBar.bounds.height, width: navigationBar.bounds.width, height: 1/UIScreen.main.scale))
            line!.isUserInteractionEnabled = false
            navigationBar.addSubview(line!)
       
        }
        line?.backgroundColor = lineColor
    }
    
    
}
