//
//  LFGesLockConstant.h
//  TouchDemo
//
//  Created by yujiao yang on 2017/6/14.
//  Copyright © 2017年 Echo. All rights reserved.
//

#ifndef LFGesLockConstant_h
#define LFGesLockConstant_h

//事件类型
typedef NS_ENUM(NSUInteger, SYGesLockEvent){
    GesLockEventSetLock  =  1, //设置手势
    GesLockEventUpdateLock,    //改变手势
    GesLockEventLoginLock,     //登录手势
};

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/*
 *  背景色
 */
#define CoreLockViewBgColor rgba(0x1B,0x1F,0x2E,1)

/*
 *  外环线条颜色：默认
 */
#define CoreLockNormalColor rgba(0x91,0x9B,0xAB,1)

/*
 *  外环线条颜色：选中
 */
#define CoreLockSelectedColor rgba(0xB3,0x96,0x5C,1)
/*
 *  警告信息的颜色
 */
#define CoreLockWarnColor rgba(0xEE,0x47,0x47,1)


#endif /* LFGesLockConstant_h */
