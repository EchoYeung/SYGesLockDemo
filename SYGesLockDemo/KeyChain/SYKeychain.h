//
//  SYKeychain.h
//  TouchDemo
//
//  Created by yujiao yang on 2017/6/20.
//  Copyright © 2017年 Echo. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SYKeychainConstant.h"

@interface SYKeychain : NSObject

+ (BOOL)saveData:(NSString *)data forKey:(NSString *)key forAccount:(NSString *)account;

+ (NSString *)getDataForKey:(NSString *)key forAccount:(NSString *)account;

+ (BOOL)deleteDataForKey:(NSString *)key forAccount:(NSString *)account;

@end
