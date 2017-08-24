//
//  SYGesLockVC.m
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/21.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "SYGesLockVC.h"
#import "SYGesLockInfoView.h"
#import "SYGesLockTipLabel.h"
#import "SYGesLockView.h"
#import "SYGesLockPresenter.h"

@interface SYGesLockVC ()
@property (nonatomic, strong) SYGesLockView     *gesLockView;     //手势路径视图
@property (nonatomic, strong) SYGesLockInfoView *gesLockInfoView; //路径缩略图
@property (nonatomic, strong) SYGesLockTipLabel *gesLockTipLabel; //提示信息
@property (nonatomic, strong) UIButton          *login_forgetBtn; //忘记密码btn
@property (nonatomic, strong) UIButton          *setup_reSetBtn;  //重新设置btn
@end

@implementation SYGesLockVC
- (instancetype)init{
    if (self = [super init]) {
        [self loadUIs];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    NSLog(@"----SYGesLockVC dealloc----");
}
#pragma mark - Public
- (void)updateTitle:(NSString *)title{
    if (title) {
        self.title = title;
    }
}
- (void)updateTip:(NSString *)tipValue isWarning:(BOOL)isWarning{
    if (isWarning) {
        [self.gesLockTipLabel showWarnMsg:tipValue];
    }else{
        [self.gesLockTipLabel showNormalMsg:tipValue];
    }
}
- (void)loadLoginUI{
    self.title = @"手势密码";
    [self.gesLockTipLabel showNormalMsg:@"请输入手势密码"];
    [self.view addSubview:self.login_forgetBtn];
}
- (void)loadSetupUI{
    if (self.login_forgetBtn.superview) {
        [self.login_forgetBtn removeFromSuperview];
    }
    self.title = @"设置手势密码";
    [self.gesLockTipLabel showNormalMsg:@"请绘制手势密码"];
}
- (void)loadUpdateUI{
    self.title = @"修改手势密码";
    [self.gesLockTipLabel showNormalMsg:@"请绘制原手势密码"];
    [self.view addSubview:self.login_forgetBtn];
}
- (void)showResetBtn{
    [self.view addSubview:self.setup_reSetBtn];
}
#pragma mark - Private
- (void)loadUIs{
    self.view.backgroundColor = CoreLockViewBgColor;
    
    CGFloat infoViewW = 51.0;
    CGFloat x = (self.view.frame.size.width - infoViewW)/2.0;
    CGFloat y = 64.0 + 62.0;
    CGRect infoViewFrame = CGRectMake(x, y, infoViewW, infoViewW);
    self.gesLockInfoView = [[SYGesLockInfoView alloc] initWithFrame:infoViewFrame];
    [self.view addSubview:self.gesLockInfoView];
    
    x = 0.0;
    y = CGRectGetMaxY(infoViewFrame) + 30.0;
    CGFloat w = self.view.frame.size.width;
    CGFloat h = 20.0;
    CGRect tipFrame = CGRectMake(x, y, w, h);
    self.gesLockTipLabel = [[SYGesLockTipLabel alloc] initWithFrame:tipFrame];
    [self.view addSubview:self.gesLockTipLabel];
    
    x = 62.0;
    CGFloat viewW = self.view.frame.size.width - x * 2;
    y = self.view.frame.size.height - 100.0 - viewW;
    CGRect viewFrame = CGRectMake(x, y, viewW, viewW);
    self.gesLockView = [[SYGesLockView alloc] initWithFrame:viewFrame];
    __weak typeof(self) weakSelf = self;
    self.gesLockView.gesLockViewResonse = ^(NSString *pwdStr, BOOL isEnd) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.gesLockInfoView drawPath:isEnd ? nil : pwdStr];
        if (isEnd) {
            [strongSelf.presenter compareUserPath:pwdStr];
        }
    };
    [self.view addSubview:self.gesLockView];
}
- (void)login_forgetBtnAction{
    [self.presenter pwdLogin];
}
- (void)setup_reSetBtnAction{
    [self.presenter resetPwd];
    [self.setup_reSetBtn removeFromSuperview];
}
#pragma mark - Getter
- (UIButton *)login_forgetBtn{
    if (nil == _login_forgetBtn) {
        _login_forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_login_forgetBtn setFrame:CGRectMake(20, self.view.frame.size.height - 10 - 40, self.view.frame.size.width - 20.0 * 2, 40.0)];
        [_login_forgetBtn setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [_login_forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_login_forgetBtn addTarget:self action:@selector(login_forgetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _login_forgetBtn;
}
- (UIButton *)setup_reSetBtn{
    if (nil == _setup_reSetBtn) {
        _setup_reSetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setup_reSetBtn setFrame:CGRectMake(20, self.view.frame.size.height - 10 - 40, self.view.frame.size.width - 20.0 * 2, 40.0)];
        [_setup_reSetBtn setTitle:@"重新设置" forState:UIControlStateNormal];
        [_setup_reSetBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_setup_reSetBtn addTarget:self action:@selector(setup_reSetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setup_reSetBtn;
}
@end
