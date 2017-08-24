//
//  SYGesLockDemoTests.m
//  SYGesLockDemoTests
//
//  Created by yujiao yang on 2017/8/18.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import <XCTest/XCTest.h>
#define WAIT \
do { \
[self expectationForNotification:@"SYUnitTest" object:nil handler:nil]; \
[self waitForExpectationsWithTimeout:60 handler:nil]; \
} while(0);

#define NOTIFY \
do { \
[[NSNotificationCenter defaultCenter] postNotificationName:@"SYUnitTest" object:nil]; \
} while(0);

@interface SYGesLockDemoTests : XCTestCase

@end

@implementation SYGesLockDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
