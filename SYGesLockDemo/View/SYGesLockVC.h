//
//  SYGesLockVC.h
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/21.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYGesLockPresenter;
@interface SYGesLockVC : UIViewController
@property (nonatomic, strong) SYGesLockPresenter *presenter;
//更新导航栏title
- (void)updateTitle:(NSString *)title;
//更新提示信息
- (void)updateTip:(NSString *)tipValue isWarning:(BOOL)isWarning;
//手势密码登录功能的UI
- (void)loadLoginUI;
//设置手势密码的UI
- (void)loadSetupUI;
//更新手势密码的UI
- (void)loadUpdateUI;
//显示 重新设置 btn
- (void)showResetBtn;

@end
