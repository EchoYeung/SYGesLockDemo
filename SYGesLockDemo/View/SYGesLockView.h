//
//  SYGesLockView.h
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/18.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYGesLockView : UIView
@property (nonatomic, copy) void(^gesLockViewResonse)(NSString *pwdStr,BOOL isEnd);
@end
