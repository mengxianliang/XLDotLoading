//
//  XLDotLoading.m
//  XLDotLoadingDemo
//
//  Created by Apple on 2017/1/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "XLDotLoading.h"
#import "XLDot.h"

@interface XLDotLoading ()
{
    NSMutableArray *_dots;
    
    CADisplayLink *_link;
    
    UIView *_dotContainer;
}
@end

@implementation XLDotLoading

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
        [self buildData];
    }
    return self;
}

//豆的宽度
-(CGFloat)dotWidth
{
    CGFloat margin = _dotContainer.bounds.size.width/5.0f;
    CGFloat dotWidth = (_dotContainer.bounds.size.width - margin)/2.0f;
    return  dotWidth;
}

-(CGFloat)speed
{
    return  2.0f;
}

//初始化两个豆
-(void)buildUI
{
    //初始化存放豆豆的的容器
    _dotContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    _dotContainer.center = self.center;
    [self addSubview:_dotContainer];
    
    //一个豆放左 一个豆放右
    _dots = [NSMutableArray new];
    NSArray *dotBackGroundColors = @[[self R:255 G:218 B:134 A:1],[self R:245 G:229 B:216 A:1]];
    NSArray *textColors = @[[self R:255 G:197 B:44 A:1],[self R:237 G:215 B:199 A:1]];
    
    for (NSInteger i = 0; i<textColors.count; i++) {
        CGFloat dotX = i==0 ? 0 : _dotContainer.bounds.size.width - [self dotWidth];
        //初始化开始运动的方向 左边的方向是向右 右边的方向是向左
        DotDitection direction = i==0 ? DotDitectionRight : DotDitectionLeft;
        XLDot *dot = [[XLDot alloc] initWithFrame:CGRectMake(dotX, 0, [self dotWidth],[self dotWidth])];
        dot.center = CGPointMake(dot.center.x, _dotContainer.bounds.size.height/2.0f);
        dot.layer.cornerRadius = dot.bounds.size.width/2.0f;
        dot.backgroundColor = dotBackGroundColors[i];
        dot.direction = direction;
        dot.textColor = textColors[i];
        [_dotContainer addSubview:dot];
        [_dots addObject:dot];
    }
}

//初始化定时刷新
-(void)buildData
{
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(reloadView)];
}

//开始动画
-(void)start
{
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

//停止动画
-(void)stop
{
    [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

//刷新UI
-(void)reloadView
{
    XLDot *dot1 = _dots.firstObject;
    
    XLDot *dot2 = _dots.lastObject;
    
    //改变移动方向、约束移动范围
    //移动到右边距时
    if (dot1.center.x >= _dotContainer.bounds.size.width - [self dotWidth]/2.0f) {
        CGPoint center = dot1.center;
        center.x = _dotContainer.bounds.size.width - [self dotWidth]/2.0f;
        dot1.center = center;
        dot1.direction = DotDitectionLeft;
        dot2.direction = DotDitectionRight;
        [_dotContainer bringSubviewToFront:dot1];
    }
    //移动到左边距时
    if (dot1.center.x <= [self dotWidth]/2.0f) {
        dot1.center = CGPointMake([self dotWidth]/2.0f, dot2.center.y);
        dot1.direction = DotDitectionRight;
        dot2.direction = DotDitectionLeft;
        [_dotContainer sendSubviewToBack:dot1];
    }
    
    //更新第一个豆的位置
    CGPoint center1 = dot1.center;
    center1.x += dot1.direction * [self speed];
    dot1.center = center1;
    //显示放大效果
    [self showAnimationsOfDot:dot1];
    
    //根据第一个豆的位置确定第二个豆的位置
    CGFloat apart = dot1.center.x - _dotContainer.bounds.size.width/2.0f;
    CGPoint center2 = dot2.center;
    center2.x = _dotContainer.bounds.size.width/2.0f - apart;
    dot2.center = center2;
    [self showAnimationsOfDot:dot2];
}

//显示放大、缩小动画
-(void)showAnimationsOfDot:(XLDot*)dot
{
    CGFloat apart = dot.center.x - _dotContainer.bounds.size.width/2.0f;
    //最大距离
    CGFloat maxAppart = (_dotContainer.bounds.size.width - [self dotWidth])/2.0f;
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

#pragma mark -
#pragma mark 功能方法

+(XLDotLoading *)getLoadingInView:(UIView *)view {
    
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
    XLDotLoading *loading = [[XLDotLoading alloc] initWithFrame:view.bounds];
    [view addSubview:loading];
    [loading start];
}

+(void)hideInView:(UIView *)view
{
    XLDotLoading *loading = [XLDotLoading getLoadingInView:view];
    if (loading) {
        [loading removeFromSuperview];
        [loading stop];
    }
}


@end
