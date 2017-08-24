//
//  SYGesLockModel.h
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/21.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYGesLockModel : NSObject
@property (nonatomic, copy, readonly) NSString *userGesPwd;

- (instancetype)initWithID:(NSString *)userID;
- (BOOL)saveGesPwd:(NSString *)pwd;
- (NSString *)getGesPwd;
- (BOOL)removeGesPwd;

//判断用户是否设置过手势
+ (BOOL)hasGes:(NSString *)userID;
//保存手势路径
+ (BOOL)saveGesPwd:(NSString *)gesPwd userID:(NSString *)userID;
//获取手势路径
+ (NSString *)getGesPwd:(NSString *)userID;
//删除手势
+ (BOOL)removeGesPwd:(NSString *)userID;
@end
