//
//  SYGesLockTipLabel.m
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/21.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "SYGesLockTipLabel.h"
#import "CALayer+Anim.h"
@implementation SYGesLockTipLabel

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //视图初始化
        [self viewPrepare];
    }
    return self;
}

#pragma mark - Private
-(void)viewPrepare{
    self.font = [UIFont systemFontOfSize:16.0f];
    self.textAlignment = NSTextAlignmentCenter;
}
#pragma mark - Public
-(void)showNormalMsg:(NSString *)msg{
    self.text = msg;
    self.textColor = CoreLockNormalColor;
}
-(void)showWarnMsg:(NSString *)msg{
    self.text = msg;
    self.textColor = CoreLockWarnColor;
    //添加一个shake动画
    [self.layer shake];
}

@end
