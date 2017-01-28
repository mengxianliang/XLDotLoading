//
//  ViewController.m
//  XLDotLoadingDemo
//
//  Created by Apple on 2017/1/28.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "XLDotLoading.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"ViewBack"];
    [self.view addSubview:imageView];
    
    [XLDotLoading showInView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
