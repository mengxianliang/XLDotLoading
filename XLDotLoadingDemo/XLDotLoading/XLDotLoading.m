//
//  XLDotLoading.m
//  XLDotLoadingDemo
//
//  Created by Apple on 2017/1/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "XLDotLoading.h"
#import "XLDot.h"

#define Spead self.bounds.size.width/50.0f

@interface XLDotLoading ()
{
    NSMutableArray *_dots;
    
    CADisplayLink *_link;
}
@end

@implementation XLDotLoading
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        [self buildData];
    }
    return self;
}

-(CGFloat)dotWidth
{
    CGFloat margin = self.bounds.size.width/5.0f;
    CGFloat dotWidth = (self.bounds.size.width - margin)/2.0f;
    return  dotWidth;
}

-(void)buildUI
{
    //一个豆放左 一个豆放右
    _dots = [NSMutableArray new];
    NSArray *dotBackGroundColors = @[[self R:255 G:218 B:134 A:1],[self R:245 G:229 B:216 A:1]];
    NSArray *textColors = @[[self R:255 G:197 B:44 A:1],[self R:237 G:215 B:199 A:1]];
    
    for (NSInteger i = 0; i<textColors.count; i++) {
        CGFloat dotX = i==0 ? 0 : self.bounds.size.width - [self dotWidth];
        //初始化开始运动的方向 左边的方向是向右 右边的方向是向左
        DotDitection direction = i==0 ? DotDitectionRight : DotDitectionLeft;
        XLDot *dot = [[XLDot alloc] initWithFrame:CGRectMake(dotX, 0, [self dotWidth],[self dotWidth])];
        dot.center = CGPointMake(dot.center.x, self.bounds.size.height/2.0f);
        dot.layer.cornerRadius = dot.bounds.size.width/2.0f;
        dot.backgroundColor = dotBackGroundColors[i];
        dot.direction = direction;
        dot.textColor = textColors[i];
        [self addSubview:dot];
        [_dots addObject:dot];
    }
}


-(void)buildData
{
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(reloadView)];
}

-(void)show
{
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)hide
{
    [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)reloadView
{
    
    XLDot *dot1 = _dots.firstObject;
    
    XLDot *dot2 = _dots.lastObject;
    
    //改变移动方向、约束移动范围
    //移动到右边距时
    if (dot1.center.x >= self.bounds.size.width - [self dotWidth]/2.0f) {
        CGPoint center = dot1.center;
        center.x = self.bounds.size.width - [self dotWidth]/2.0f;
        dot1.center = center;
        dot1.direction = DotDitectionLeft;
        dot2.direction = DotDitectionRight;
        [self bringSubviewToFront:dot1];
    }
    //移动到左边距时
    if (dot1.center.x <= [self dotWidth]/2.0f) {
        dot1.center = CGPointMake([self dotWidth]/2.0f, dot2.center.y);
        dot1.direction = DotDitectionRight;
        dot2.direction = DotDitectionLeft;
        [self sendSubviewToBack:dot1];
    }
    
    //更新第一个豆的位置
    CGPoint center1 = dot1.center;
    center1.x += dot1.direction * Spead;
    dot1.center = center1;
    //显示放大效果
    [self showAnimationsOfDot:dot1];
    
    //根据第一个豆的位置确定第二个豆的位置
    CGFloat apart = dot1.center.x - self.bounds.size.width/2.0f;
    CGPoint center2 = dot2.center;
    center2.x = self.bounds.size.width/2.0f - apart;
    dot2.center = center2;
    [self showAnimationsOfDot:dot2];
}

//显示放大、缩小动画
-(void)showAnimationsOfDot:(XLDot*)dot
{
    CGFloat apart = dot.center.x - self.bounds.size.width/2.0f;
    //最大距离
    CGFloat maxAppart = (self.bounds.size.width - [self dotWidth])/2.0f;
    //移动距离和最大距离的比例
    CGFloat appartScale = apart/maxAppart;
    //获取比例对应余弦曲线的Y值
    CGFloat transfomscale = cos(appartScale * M_PI/2.0);
    //向右移动则 中间变大 两边变小
    if (dot.direction == DotDitectionLeft) {
        dot.transform = CGAffineTransformMakeScale(1 + transfomscale/4.0f, 1 + transfomscale/4.0f);
        //向左移动则 中间变小 两边变大
    }else if (dot.direction == DotDitectionRight){
        dot.transform = CGAffineTransformMakeScale(1 - transfomscale/4.0f,1 - transfomscale/4.0f);
    }
}

-(UIColor*)R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a
{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

+(XLDotLoading *)loadingInView:(UIView *)view {
    
    XLDotLoading *loading = nil;
    for (XLDotLoading *subview in view.subviews) {
        if ([subview isKindOfClass:[XLDotLoading class]]) {
            loading = subview;
        }
    }
    return loading;
}

+(void)showInView:(UIView*)view
{
    XLDotLoading *loading = [[XLDotLoading alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    loading.center = view.center;
    [view addSubview:loading];
    [loading show];
}

+(void)hideInView:(UIView *)view
{
    XLDotLoading *loading = [XLDotLoading loadingInView:view];
    if (loading) {
        [loading removeFromSuperview];
        [loading hide];
    }
}


@end
