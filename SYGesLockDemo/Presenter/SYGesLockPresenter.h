//
//  SYGesLockPresenter.h
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/21.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYGesLockConstant.h"
@class SYGesLockVC;
@class SYGesLockModel;
@interface SYGesLockPresenter : NSObject
@property (nonatomic, assign) SYGesLockEvent event;
- (instancetype)initWithView:(SYGesLockVC *)viewVC model:(SYGesLockModel *)model;
- (void)compareUserPath:(NSString *)userPath;
//账号密码登录
- (void)pwdLogin;
//设置手势密码过程中，重新设置功能
- (void)resetPwd;
@end
