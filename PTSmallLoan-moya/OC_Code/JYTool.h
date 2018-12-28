//
//  JYTool.h
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/20.
//  Copyright © 2018 johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCellularData.h>
#import <UIKit/UIKit.h>

@interface JYTool : NSObject

// MARK: -- AlertView弹窗
- (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle confirm:(void (^)(void))confirm cancle:(void (^)(void))cancle;

/**
 给一个view添加一根边线

 @param view 要添加线的view
 @param color 线的颜色
 @param edge 不要的边设为负数，作为宽度使用
 */
+ (UIView *)addLineInView:(UIView *)view color:(UIColor *)color edge:(UIEdgeInsets)edge;

+ (void)addLinesInView:(NSArray *)views color:(UIColor *)color edge:(UIEdgeInsets)edge;

@end
