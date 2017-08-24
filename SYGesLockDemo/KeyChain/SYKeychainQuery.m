//
//  SYKeychainQuery.m
//  TouchDemo
//
//  Created by yujiao yang on 2017/6/20.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "SYKeychainQuery.h"

@implementation SYKeychainQuery

- (BOOL)save:(NSError *__autoreleasing *)error {
    
    if(!self.service || !self.account || !self.passwordData){
        return NO;
    }
    NSMutableDictionary *query = nil;
    NSMutableDictionary *searchQuery = [self query];
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchQuery, nil);
    
    if (status == errSecSuccess) {//item存在 更新数据
        query = [[NSMutableDictionary alloc]init];
        [query setObject:self.passwordData forKey:(__bridge id)kSecValueData];
        status = SecItemUpdate((__bridge CFDictionaryRef)(searchQuery), (__bridge CFDictionaryRef)(query));
    }
    else if(status == errSecItemNotFound){//item不存在 创建数据
        query = [self query];
        [query setObject:self.passwordData forKey:(__bridge id)kSecValueData];
        status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    }
    
    return (status == errSecSuccess);
}

- (BOOL)deleteItem:(NSError **)error{
    if (!self.service || !self.account) {
        return NO;
    }
    
    NSMutableDictionary *query = [self query];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);

    return (status == errSecSuccess);
}

- (BOOL)fetch:(NSError **)error{
    if (!self.service || !self.account) {
        return NO;
    }
    
    CFTypeRef result = NULL;
    NSMutableDictionary *query = [self query];
    [query setObject:@YES forKey:(__bridge id)kSecReturnData];
    [query setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    if (status != errSecSuccess) {
        
        return NO;
    }
    
    self.passwordData = (__bridge_transfer NSData *)result;
    return YES;
}
#pragma mark - Setter/Getter
- (void)setPasswordObject:(id<NSCoding>)passwordObject{
    self.passwordData = [NSKeyedArchiver archivedDataWithRootObject:passwordObject];
}
- (id<NSCopying>)passwordObject {
    if ([self.passwordData length]) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:self.passwordData];
    }
    return nil;
}
- (void)setPassword:(NSString *)password {
    self.passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)password {
    if ([self.passwordData length]) {
        return [[NSString alloc] initWithData:self.passwordData encoding:NSUTF8StringEncoding];
    }
    return nil;
}
#pragma mark - Private
- (NSMutableDictionary *)query{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:3];
    [dictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    if (self.service) {
        [dictionary setObject:self.service forKey:(__bridge id)kSecAttrService];
    }
    
    if (self.account) {
        [dictionary setObject:self.account forKey:(__bridge id)kSecAttrAccount];
    }
    
#ifdef SAMKEYCHAIN_ACCESS_GROUP_AVAILABLE
#if !TARGET_IPHONE_SIMULATOR
    if (self.accessGroup) {
        [dictionary setObject:self.accessGroup forKey:(__bridge id)kSecAttrAccessGroup];
    }
#endif
#endif

    return dictionary;
}

@end
