//
//  SYGesLockInfoView.m
//  SYGesLockDemo
//
//  Created by yujiao yang on 2017/8/21.
//  Copyright © 2017年 Echo. All rights reserved.
//

#import "SYGesLockInfoView.h"
#import "CAShapeLayer+SYGesLock.h"

static CGFloat kMarginValue = 12.0;

@interface SYGesLockInfoView ()
@property (nonatomic, strong) NSMutableArray *cycleLayerArr;
@property (nonatomic, strong) NSMutableArray <NSNumber *>*indexArr;
@end

@implementation SYGesLockInfoView
#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _cycleLayerArr = [NSMutableArray array];
        //解锁视图准备
        [self infoViewPrepare];
    }
    return self;
}
#pragma mark - Getter
- (NSMutableArray *)indexArr{
    if (_indexArr == nil) {
        _indexArr = [NSMutableArray array];
    }
    return _indexArr;
}
#pragma mark - Public
- (void)drawPath:(NSString *)value{
    [self resetView];
    if (value == nil) {
        return;
    }
    
    for (int i = 0; i < value.length; i++) {
        NSString *temp = [value substringWithRange:NSMakeRange(i, 1)];
        NSInteger index = temp.integerValue;
        [self.indexArr addObject:@(index)];
        
        CAShapeLayer *layer = self.cycleLayerArr[index];
        layer.fillColor = CoreLockSelectedColor.CGColor;
        layer.strokeColor = CoreLockSelectedColor.CGColor;
    }

}
#pragma mark - Private
- (void)infoViewPrepare{
    CGFloat itemViewWH = (self.frame.size.width - 2 * kMarginValue) /3.0f;
    for (NSUInteger idx=0; idx<9; idx++) {
        NSUInteger row = idx % 3;
        NSUInteger col = idx / 3;
        CGFloat x = kMarginValue * row + row * itemViewWH;
        CGFloat y = kMarginValue * col + col * itemViewWH;
        CGRect frame = CGRectMake(x, y, itemViewWH, itemViewWH);
        
        CAShapeLayer *layer = [CAShapeLayer cycleLayer:itemViewWH/2 fillColor:CoreLockNormalColor strokeColor:CoreLockNormalColor];
        layer.frame = frame;
        [_cycleLayerArr addObject:layer];
        [self.layer addSublayer:layer];
    }
}
- (void)resetView{
    if (self.indexArr.count > 0) {
        for (NSNumber *indexNum in self.indexArr) {
            NSInteger index = indexNum.integerValue;
            CAShapeLayer *layer = self.cycleLayerArr[index];
            layer.fillColor = CoreLockNormalColor.CGColor;
            layer.strokeColor = CoreLockNormalColor.CGColor;
        }
        [self.indexArr removeAllObjects];
    }
    
}
@end
