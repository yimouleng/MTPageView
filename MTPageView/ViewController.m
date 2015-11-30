//
//  ViewController.m
//  MTPageView
//
//  Created by Eli on 15/11/30.
//  Copyright © 2015年 Ely. All rights reserved.
//

#import "ViewController.h"
#import "MTPageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //本地图片
    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",nil];
    //网络图片
    //    NSArray *imageArray = @[@"http://i1.douguo.net//upload/banner/0/6/a/06e051d7378040e13af03db6d93ffbfa.jpg", @"http://i1.douguo.net//upload/banner/9/3/4/93f959b4e84ecc362c52276e96104b74.jpg", @"http://i1.douguo.net//upload/banner/5/e/3/5e228cacf18dada577269273971a86c3.jpg", @"http://i1.douguo.net//upload/banner/d/8/2/d89f438789ee1b381966c1361928cb32.jpg"];
    MTPageView *pageView = [[MTPageView alloc] initPageViewFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    //是否是网络图片
    pageView.isWebImage = NO;
    //存放图片数组
    pageView.imageArray = imageArray;
    //停留时间
    pageView.duration = 5.0;
    
    [self.view addSubview:pageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
