//
//  SYGesLockPresenter.m
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/21.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "SYGesLockPresenter.h"
#import "SYGesLockVC.h"
#import "SYGesLockModel.h"

@interface SYGesLockPresenter ()
@property (nonatomic, weak)   SYGesLockVC    *viewVC;
@property (nonatomic, strong) SYGesLockModel *model;
@property (nonatomic, copy)   NSString       *tempValue;
@property (nonatomic, assign) NSInteger      count;
@end
@implementation SYGesLockPresenter
- (instancetype)initWithView:(SYGesLockVC *)viewVC model:(SYGesLockModel *)model{
    self = [super init];
    if (self) {
        _viewVC = viewVC;
        _model = model;
        _count = 5;
    }
    return self;
}
- (void)dealloc{
    NSLog(@"----SYGesLockPresenter dealloc----");
}
#pragma mark - Public
- (void)compareUserPath:(NSString *)userPath{
    if (userPath.length < 4) {
        [self.viewVC updateTip:@"至少连接四个点，请重新绘制" isWarning:YES];
        return;
    }
    switch (self.event) {
        case GesLockEventLoginLock:
            [self loginProcess:userPath];
            break;
        case GesLockEventSetLock:
            [self setupProcess:userPath];
            break;
        case GesLockEventUpdateLock:
            [self updateProcess:userPath];
            break;
    }
}
- (void)pwdLogin{
    [self.model removeGesPwd];
    [self.viewVC.navigationController popViewControllerAnimated:YES];
    NSLog(@"跳转到账号密码登录流程");
}
- (void)resetPwd{
    [self.viewVC updateTip:@"请绘制手势密码" isWarning:NO];
    self.tempValue = nil;
}
#pragma mark - Setter
- (void)setEvent:(SYGesLockEvent)event{
    _event = event;
    [self loadViewUI];
}
#pragma mark - Private
- (void)loadViewUI{
    switch (self.event) {
        case GesLockEventSetLock:{
            [self.viewVC loadSetupUI];
        }
            break;
        case GesLockEventUpdateLock:{
            [self.viewVC loadUpdateUI];
        }
            break;
        case GesLockEventLoginLock:{
            [self.viewVC loadLoginUI];
        }
            break;
    }
}
- (void)loginProcess:(NSString *)value{
    if ([value isEqualToString:self.model.userGesPwd]) {
        NSLog(@"登录成功");
        [self.viewVC.navigationController popViewControllerAnimated:YES];
    }else{
        self.count--;
        if (self.count) {
            NSString *tip = [NSString stringWithFormat:@"密码错误,还可以输入%ld次",(long)self.count];
            [self.viewVC updateTip:tip isWarning:YES];
        }else{
            [self pwdLogin];
        }
    }
}
- (void)setupProcess:(NSString *)value{
    if(self.tempValue && [self.tempValue isEqualToString:value]){
        [self.model saveGesPwd:value];
        self.tempValue = nil;
        [self.viewVC.navigationController popViewControllerAnimated:YES];
    }else if (self.tempValue){
        [self.viewVC updateTip:@"手势密码不一致，请重新绘制" isWarning:YES];
        [self.viewVC showResetBtn];
    }else{
        self.tempValue = value;
        [self.viewVC updateTip:@"请再次绘制手势密码" isWarning:NO];
    }
}
- (void)updateProcess:(NSString *)value{
    if ([self.model.userGesPwd isEqualToString:value]) {
        self.event = GesLockEventSetLock;
    }else{
        [self.viewVC updateTip:@"密码错误,请重新输入" isWarning:YES];
    }
}
@end
