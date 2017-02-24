//
//  XLDotLoading.h
//  XLDotLoadingDemo
//
//  Created by Apple on 2017/1/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLDotLoading : UIView

//显示方法
+(void)showInView:(UIView*)view;
//隐藏方法
+(void)hideInView:(UIView*)view;

-(void)start;

-(void)stop;

@end
