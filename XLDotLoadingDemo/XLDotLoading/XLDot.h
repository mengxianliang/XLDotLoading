//
//  XLDot.h
//  XLDotLoadingDemo
//
//  Created by Apple on 2017/1/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DotDitection)
{
    DotDitectionLeft = -1,
    DotDitectionRight = 1,
};


@interface XLDot : UIView

//移动方向 就两种 左、右
@property (nonatomic,assign) DotDitection direction;
//字体颜色
@property (nonatomic,strong) UIColor *textColor;

@end
