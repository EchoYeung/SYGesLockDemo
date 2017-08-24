//
//  SYGesLockDotView.m
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/18.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "SYGesLockDotView.h"
#import "CAShapeLayer+SYGesLock.h"
static const CGFloat CoreLockArcWHR = .3f;
@interface SYGesLockDotView ()
@property (nonatomic, strong) CAShapeLayer *boderCycleLayer;
@property (nonatomic, strong) CAShapeLayer *solidCycleLayer;
@end
@implementation SYGesLockDotView
#pragma mark - LifeCycle
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.boderCycleLayer = [CAShapeLayer cycleLayer:frame.size.width/2.0 fillColor:[UIColor clearColor] strokeColor:CoreLockNormalColor];
        self.boderCycleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.layer addSublayer:self.boderCycleLayer];
    }
    
    return self;
}
#pragma mark - Private
- (void)drawView{
    
    UIColor *color = CoreLockNormalColor;
    if (self.selected) {
        [self.layer addSublayer:self.solidCycleLayer];
        color = CoreLockSelectedColor;
    }else{
        [self.solidCycleLayer removeFromSuperlayer];
    }
    
    self.boderCycleLayer.strokeColor = color.CGColor;
}

#pragma mark - setter/getter

- (CAShapeLayer *)solidCycleLayer{
    if (_solidCycleLayer == nil) {
        
        CGFloat w = self.frame.size.width * CoreLockArcWHR;
        CGFloat x = (self.frame.size.width - w)/2.0;
        _solidCycleLayer = [CAShapeLayer cycleLayer:w/2 fillColor:CoreLockSelectedColor strokeColor:nil];
        _solidCycleLayer.frame = CGRectMake(x, x,w, w);
        
    }
    return _solidCycleLayer;
}
-(void)setSelected:(BOOL)selected{
    
    _selected = selected;
    [self drawView];
}
@end
