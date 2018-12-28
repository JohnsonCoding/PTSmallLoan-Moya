//
//  JYTool.m
//  PTSmallLoan-swift
//
//  Created by 江勇 on 2018/12/20.
//  Copyright © 2018 johnson. All rights reserved.
//

#import "JYTool.h"

typedef void (^confirm)(void);
typedef void (^cancle)(void);

@interface JYTool() {
    confirm confirmParam;
    cancle  cancleParam;
}

@end

@implementation JYTool

- (void)showAlertView:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle confirm:(void (^)(void))confirm cancle:(void (^)(void))cancle{
    
    confirmParam = confirm;
    cancleParam = cancle;
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIColor *color333333 = [UIColor colorWithRed: 51.0 / 255.0 green: 51.0 / 255.0 blue: 51.0 / 255.0 alpha:1];
        UIColor *color3388E0 = [UIColor colorWithRed: 51.0 / 255.0 green: 136.0 / 255.0 blue: 224.0 / 255.0 alpha:1];
        @try {
            if (title != nil && ![title isEqualToString:@""]) {
                NSMutableAttributedString * attibuteTitle = [[NSMutableAttributedString alloc] initWithString:title];
                [attibuteTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize: 15] range:NSMakeRange(0, [[attibuteTitle string] length])];
                [attibuteTitle addAttribute:NSForegroundColorAttributeName value: color333333 range:NSMakeRange(0, [[attibuteTitle string] length])];
                [alertController setValue:attibuteTitle forKey:@"attributedTitle"];
            }
            
            if (message != nil && ![message isEqualToString:@""]) {
                NSMutableAttributedString * attibuteMessage = [[NSMutableAttributedString alloc] initWithString:message];
                if (title != nil && ![title isEqualToString:@""]) {
                    [attibuteMessage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize: 11] range:NSMakeRange(0, [[attibuteMessage string] length])];
                }else{
                    [attibuteMessage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize: 15] range:NSMakeRange(0, [[attibuteMessage string] length])];
                }
                [attibuteMessage addAttribute:NSForegroundColorAttributeName value: color333333 range:NSMakeRange(0, [[attibuteMessage string] length])];
                [alertController setValue:attibuteMessage forKey:@"attributedMessage"];
            }
        } @catch (NSException *exception) {
            //            NSLog(@"%@", exception);
        }
        
        if (cancelButtonTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (cancle) {
                    cancle();
                }
            }];
            @try {
                [cancelAction setValue: color3388E0 forKey:@"_titleTextColor"];
            } @catch (NSException *exception) {
                //                NSLog(@"%@", exception);
            } @finally {
                [alertController addAction:cancelAction];
            }
        }
        
        if (otherButtonTitle) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if (confirm) {
                    confirm();
                }
            }];
            @try {
                [otherAction setValue: color3388E0 forKey:@"_titleTextColor"];
            } @catch (NSException *exception) {
                //                NSLog(@"%@", exception);
            } @finally {
                [alertController addAction:otherAction];
            }
        }
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    
    
}


+ (UIView *)addLineInView:(UIView *)view color:(UIColor *)color edge:(UIEdgeInsets)edge{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = color;
    [view addSubview:line];
    line.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"line":line};
    NSString *H;
    NSString *V;
    if (edge.left <0) {
        edge.left = -edge.left;
        H = @"H:[line(left)]-right-|";
        V = @"V:|-top-[line]-bottom-|";
    }else if (edge.right <0){
        edge.right = -edge.right;
        H = @"H:|-left-[line(right)]";
        V = @"V:|-top-[line]-bottom-|";
    }else if (edge.top <0){
        edge.top = -edge.top;
        H = @"H:|-left-[line]-right-|";
        V = @"V:[line(top)]-bottom-|";
    }else if (edge.bottom < 0){
        edge.bottom = -edge.bottom;
        H = @"H:|-left-[line]-right-|";
        V = @"V:|-top-[line(bottom)]";
    }else{
        [line removeFromSuperview];
        return nil;
    }
    NSDictionary *metrics = @{@"left": @(edge.left), @"right": @(edge.right), @"top": @(edge.top), @"bottom": @(edge.bottom)};
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:H options:0 metrics:metrics views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:V options:0 metrics:metrics views:views]];
    return line;
}

+ (void)addLinesInView:(NSArray *)views color:(UIColor *)color edge:(UIEdgeInsets)edge{
    for (UIView *view in views) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addLineInView:view color:color edge:edge];
        }
    }
}


@end
