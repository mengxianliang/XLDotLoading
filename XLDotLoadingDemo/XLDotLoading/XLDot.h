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

@property (nonatomic,assign) DotDitection direction;

@property (nonatomic,strong) UIColor *textColor;

@end
