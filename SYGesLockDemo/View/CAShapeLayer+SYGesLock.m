//
//  CAShapeLayer+SYGesLock.m
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/18.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "CAShapeLayer+SYGesLock.h"

@implementation CAShapeLayer (SYGesLock)
+ (CAShapeLayer *)cycleLayer:(float)radius
                    fillColor:(UIColor *)fillColor
                 strokeColor:(UIColor *)strokeColor{
    CAShapeLayer *cycleLayer = [CAShapeLayer layer];
    cycleLayer.contentsScale = [UIScreen mainScreen].scale;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:0.0 endAngle:180.0 clockwise:YES];
    cycleLayer.path = path.CGPath;
    if (fillColor) {
        cycleLayer.fillColor = fillColor.CGColor;
    }
    if (strokeColor) {
        cycleLayer.strokeColor = strokeColor.CGColor;
    }
    return cycleLayer;
}
@end
