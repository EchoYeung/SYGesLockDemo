//
//  CAShapeLayer+SYGesLock.h
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/18.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CAShapeLayer (SYGesLock)
+ (CAShapeLayer *)cycleLayer:(float)radius
                    fillColor:(UIColor *)fillColor
                 strokeColor:(UIColor *)strokeColor;
@end
