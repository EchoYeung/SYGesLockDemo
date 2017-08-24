//
//  SYKeychainQuery.h
//  TouchDemo
//
//  Created by yujiao yang on 2017/6/20.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYKeychainQuery : NSObject

/** kSecAttrAccount */
@property (nonatomic, copy, nullable) NSString *account;

/** kSecAttrService */
@property (nonatomic, copy, nullable) NSString *service;

/** 存储的数据 Root storage for password information */
@property (nonatomic, copy, nullable) NSData *passwordData;

/**
 This property automatically transitions between an object and the value of
 `passwordData` using NSKeyedArchiver and NSKeyedUnarchiver.
 */
@property (nonatomic, copy, nullable) id<NSCoding> passwordObject;

/**
 Convenience accessor for setting and getting a password string. Passes through
 to `passwordData` using UTF-8 string encoding.
 */
@property (nonatomic, copy, nullable) NSString *password;

#ifdef SAMKEYCHAIN_ACCESS_GROUP_AVAILABLE
/** kSecAttrAccessGroup (only used on iOS) */
@property (nonatomic, copy, nullable) NSString *accessGroup;
#endif

- (BOOL)save:(NSError **)error;

- (BOOL)deleteItem:(NSError **)error;

- (BOOL)fetch:(NSError **)error;
@end

NS_ASSUME_NONNULL_END
