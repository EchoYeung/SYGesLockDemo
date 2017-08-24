//
//  SYKeychain.m
//  TouchDemo
//
//  Created by yujiao yang on 2017/6/20.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "SYKeychain.h"
#import "SYKeychainQuery.h"

@interface SYKeychain ()

@end

@implementation SYKeychain

+ (BOOL)saveData:(NSString *)data forKey:(NSString *)key forAccount:(NSString *)account{
    SYKeychainQuery *query = [[SYKeychainQuery alloc] init];
    query.service = key;
    query.account = account;
    query.password = data;

    return [query save:nil];
}

+ (NSString *)getDataForKey:(NSString *)key forAccount:(NSString *)account{
   	SYKeychainQuery *query = [[SYKeychainQuery alloc] init];
    query.service = key;
    query.account = account;
    [query fetch:nil];
    return query.password;
}

+ (BOOL)deleteDataForKey:(NSString *)key forAccount:(NSString *)account{
    SYKeychainQuery *query = [[SYKeychainQuery alloc] init];
    query.service = key;
    query.account = account;
    return [query deleteItem:nil];
}


@end
