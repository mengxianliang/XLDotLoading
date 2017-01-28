//
//  XLDot.m
//  XLDotLoadingDemo
//
//  Created by Apple on 2017/1/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "XLDot.h"

@interface XLDot ()
{
    UILabel *_label;
}
@end

@implementation XLDot

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    self.layer.cornerRadius = self.bounds.size.width/2.0f;
    self.layer.masksToBounds = true;
    
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont boldSystemFontOfSize:20];
    _label.text = @"¥";
    _label.adjustsFontSizeToFitWidth = true;
    [self addSubview:_label];
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _label.textColor = textColor;
}

@end
