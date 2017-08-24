//
//  ViewController.m
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/18.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "ViewController.h"
#import "SYGesLockVC.h"
#import "SYGesLockPresenter.h"
#import "SYGesLockModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *gesView;
@property (weak, nonatomic) IBOutlet UILabel *gesStatus;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)gesViewTap:(UITapGestureRecognizer *)sender {
    if([SYGesLockModel hasGes:@"userID"]){
        [self updateGesPwd];
    }else{
        [self setupGesPwd];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([SYGesLockModel hasGes:@"userID"]){
        self.gesStatus.text = @"已设置";
    }else{
        self.gesStatus.text = @"未设置";
    }
}
- (IBAction)loginBtnAction:(UIButton *)sender {
    NSLog(@"账号密码登录");
    if([SYGesLockModel hasGes:@"userID"]){
        [self loginWithGes];
    }else{
         [self setupGesPwd];
    }
}
- (void)setupGesPwd{
    SYGesLockModel *model = [[SYGesLockModel alloc] initWithID:@"userID"];
    SYGesLockVC *view = [[SYGesLockVC alloc] init];
    SYGesLockPresenter *presenter = [[SYGesLockPresenter alloc] initWithView:view model:model];
    presenter.event = GesLockEventSetLock;
    view.presenter = presenter;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)updateGesPwd{
    SYGesLockModel *model = [[SYGesLockModel alloc] initWithID:@"userID"];
    SYGesLockVC *view = [[SYGesLockVC alloc] init];
    SYGesLockPresenter *presenter = [[SYGesLockPresenter alloc] initWithView:view model:model];
    presenter.event = GesLockEventUpdateLock;
    view.presenter = presenter;
    [self.navigationController pushViewController:view animated:YES];
}
- (void)loginWithGes{
    SYGesLockModel *model = [[SYGesLockModel alloc] initWithID:@"userID"];
    SYGesLockVC *view = [[SYGesLockVC alloc] init];
    SYGesLockPresenter *presenter = [[SYGesLockPresenter alloc] initWithView:view model:model];
    presenter.event = GesLockEventLoginLock;
    view.presenter = presenter;
    [self.navigationController pushViewController:view animated:YES];
}
@end
