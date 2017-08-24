//
//  CALayer+Anim.m
//  TouchDemo
//
//  Created by yujiao yang on 2017/6/20.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "CALayer+Anim.h"

@implementation CALayer (Anim)

- (void)shake{
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 16;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    //时长
    kfa.duration = .1f;
    
    //重复
    kfa.repeatCount =2;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [self addAnimation:kfa forKey:@"shake"];
}

@end
