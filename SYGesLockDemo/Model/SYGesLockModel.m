//
//  SYGesLockModel.m
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/21.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "SYGesLockModel.h"
#import "SYKeychain.h"
@interface SYGesLockModel()
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy, readwrite) NSString *userGesPwd;
@end
@implementation SYGesLockModel
- (instancetype)initWithID:(NSString *)userID{
    if(self = [super init]){
        _userID = userID;
    }
    return self;
}
- (void)dealloc{
    NSLog(@"----SYGesLockModel dealloc----");
}
- (NSString *)userGesPwd{
    if (nil == _userGesPwd) {
        _userGesPwd = [self getGesPwd];
    }
    return _userGesPwd;
}
- (BOOL)saveGesPwd:(NSString *)pwd{
    return [SYKeychain saveData:pwd forKey:kKeychainItem_Gesture forAccount:self.userID];
}
- (NSString *)getGesPwd{
    return [SYKeychain getDataForKey:kKeychainItem_Gesture forAccount:self.userID];
}
- (BOOL)removeGesPwd{
    return [SYKeychain deleteDataForKey:kKeychainItem_Gesture forAccount:self.userID];
}

+ (BOOL)hasGes:(NSString *)userID{
    return [SYKeychain getDataForKey:kKeychainItem_Gesture forAccount:userID];;
}
+ (BOOL)saveGesPwd:(NSString *)gesPwd userID:(NSString *)userID{
    return [SYKeychain saveData:gesPwd forKey:kKeychainItem_Gesture forAccount:userID];
}
+ (NSString *)getGesPwd:(NSString *)userID{
    return [SYKeychain getDataForKey:kKeychainItem_Gesture forAccount:userID];
}
+ (BOOL)removeGesPwd:(NSString *)userID{
    return [SYKeychain deleteDataForKey:kKeychainItem_Gesture forAccount:userID];
}
@end
