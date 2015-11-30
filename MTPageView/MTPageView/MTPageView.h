//
//  PageView.h
//  MTPageView
//
//  Created by Ely on 15-8-6.
//  Copyright (c) 2015年 Ely. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageViewDelegate <NSObject>

- (void)didSelectPageViewWithNumber:(NSInteger)selectNumber;

@end


@interface MTPageView : UIView

@property (nonatomic, strong) NSArray * imageArray;

@property (nonatomic ,assign) NSTimeInterval duration;

@property (nonatomic ,assign) BOOL isWebImage;

-(instancetype)initPageViewFrame:(CGRect)frame;

@property (nonatomic ,weak) id<PageViewDelegate> delegate;

@end
