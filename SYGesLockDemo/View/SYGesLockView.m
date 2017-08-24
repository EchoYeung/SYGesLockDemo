//
//  SYGesLockView.m
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/18.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "SYGesLockView.h"
#import "SYGesLockDotView.h"

static const CGFloat marginValue = 40.0;
@interface SYGesLockView ()
@property (nonatomic, strong) NSMutableArray  *pathsViewsArr;
@property (nonatomic, strong) CAShapeLayer    *pathLayer;
@property (nonatomic, copy)   NSMutableString *pwdStr;
@end

@implementation SYGesLockView
#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self lockViewPrepare];
    }
    return self;
}
#pragma mark - Setter
- (NSMutableArray *)pathsViewsArr{
    if (_pathsViewsArr == nil) {
        _pathsViewsArr = [NSMutableArray array];
    }
    return _pathsViewsArr;
}
- (CAShapeLayer *)pathLayer{
    if (_pathLayer == nil) {
        _pathLayer = [CAShapeLayer layer];
        _pathLayer.contentsScale = [UIScreen mainScreen].scale;
        _pathLayer.strokeColor = CoreLockSelectedColor.CGColor;
        _pathLayer.fillColor = [UIColor clearColor].CGColor;
        _pathLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _pathLayer;
}
- (NSMutableString *)pwdStr{
    if (_pwdStr == nil) {
        _pwdStr = [NSMutableString string];
    }
    return _pwdStr;
}
#pragma mark - Private
- (void)lockViewPrepare{
    CGFloat itemViewWH = (self.frame.size.width - 2 * marginValue) /3.0f;
    for (NSUInteger idx=0; idx<9; idx++) {
        
        NSUInteger row = idx % 3;
        NSUInteger col = idx / 3;
        CGFloat x = marginValue * row + row * itemViewWH;
        CGFloat y = marginValue * col + col * itemViewWH;
        CGRect frame = CGRectMake(x, y, itemViewWH, itemViewWH);
        
        SYGesLockDotView *itemView = [[SYGesLockDotView alloc] initWithFrame:frame];
        itemView.tag = idx;
        
        [self addSubview:itemView];
    }
}
- (SYGesLockDotView *)itemViewWithTouchLocation:(CGPoint)loc{
    
    SYGesLockDotView *itemView = nil;
    
    for (SYGesLockDotView *itemViewSub in self.subviews) {
        
        if(!CGRectContainsPoint(itemViewSub.frame, loc)) continue;
        itemView = itemViewSub;
        break;
    }
    
    return itemView;
}
- (void)handleItemView:(SYGesLockDotView *)itemView{
    //选中
    itemView.selected = YES;
    
    [self drawPathLayer];
}
- (void)drawPathLayer{
    [self.pathLayer removeFromSuperlayer];
    
    if (_pathsViewsArr == nil || self.pathsViewsArr.count == 0) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [_pathsViewsArr enumerateObjectsUsingBlock:^(SYGesLockDotView *itemView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGPoint directPoint = itemView.center;
        if (idx == 0) {
            
            [path moveToPoint:directPoint];
        }else{
            [path addLineToPoint:directPoint];
        }
    }];
    
    self.pathLayer.path = path.CGPath;
    [self.layer insertSublayer:self.pathLayer atIndex:0];
    
}
- (void)handleTouches:(NSSet *)touches{
    //取出触摸点
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInView:self];
    SYGesLockDotView *itemView = [self itemViewWithTouchLocation:loc];
    //如果为空，返回
    if(itemView == nil) return;
    //如果已经存在，返回
    if([self.pathsViewsArr containsObject:itemView]) return;
    //添加
    [self.pathsViewsArr addObject:itemView];
    //item处理
    [self handleItemView:itemView];
    //记录密码
    [self.pwdStr appendFormat:@"%@",@(itemView.tag)];
    
    if (self.gesLockViewResonse) {
        self.gesLockViewResonse(self.pwdStr,NO);
    }
}
-(void)gestureEnd{
    if(self.pwdStr.length != 0){
        NSLog(@"%@",self.pwdStr);
    }
    for (SYGesLockDotView *itemView in self.pathsViewsArr) {
        itemView.selected = NO;
    }
    //清空数组所有对象
    [self.pathsViewsArr removeAllObjects];
    [self.pathLayer removeFromSuperlayer];
    if (self.gesLockViewResonse) {
        self.gesLockViewResonse(self.pwdStr,YES);
    }
    self.pwdStr = nil;
}
#pragma mark - Touch

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //解锁处理
    [self handleTouches:touches];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //解锁处理
    [self handleTouches:touches];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //手势结束
    [self gestureEnd];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    //手势结束
    NSLog(@"手势取消");
}
@end
