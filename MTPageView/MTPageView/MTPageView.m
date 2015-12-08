//
//  PageView.m
//  MTPageView
//
//  Created by Ely on 15-8-6.
//  Copyright (c) 2015年 Ely. All rights reserved.
//

#import "MTPageView.h"
#import "UIImageView+WebCache.h"

@interface MTPageView () <UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *scrollView;

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) NSTimer *timer;



@end


@implementation MTPageView

-(instancetype)initPageViewFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    [self setUpScrollView:imageArray];
    [self setUpImage:imageArray];
    [self setUpPageControl:imageArray];
    //保证不管先设置图片来源还是时间，都可以start
    [self.timer invalidate];
    [self startTimer];
}

-(void)setDuration:(NSTimeInterval)duration
{
    _duration = duration;
    [self.timer invalidate];
    [self startTimer];
}

/**
 *  设置scrollView
 */
-(void)setUpScrollView:(NSArray *)array
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageViewClick:)];
    [scrollView addGestureRecognizer:tapGesture];

    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

/**
 *  设置scrollView的内容图片：如果是网络图片的话就用SDWebImage加载，本地则直接设置
 *  暂时没想出其他方法。
 */
-(void)setUpImage:(NSArray *)array
{
    CGSize contentSize;
    CGPoint startPoint;
    NSLog(@"%d",_isWebImage);
    if (array.count > 1) {     //多张图片
        for (int i = 0 ; i < array.count + 2; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            if (i == 0) {
                //第一个imageview放最后一张
//                imageView.image = [UIImage imageNamed:array[array.count - 1]]
                _isWebImage==YES?[imageView sd_setImageWithURL:[NSURL URLWithString:array[array.count - 1]]]:(imageView.image = [UIImage imageNamed:array[array.count - 1]]);
            }else if(i == array.count + 1){
                //最后一个imageview放第一张
//                imageView.image = [UIImage imageNamed:array[0]];
                _isWebImage==YES?[imageView sd_setImageWithURL:[NSURL URLWithString:array[0]]]:(imageView.image = [UIImage imageNamed:array[0]]);
            }else{
                //4，1，2，3，4，1类似
//                imageView.image = [UIImage imageNamed:array[i - 1]];
                _isWebImage==YES?[imageView sd_setImageWithURL:[NSURL URLWithString:array[i - 1]]]:(imageView.image = [UIImage imageNamed:array[i - 1]]);
            }
            [self.scrollView addSubview:imageView];
            contentSize = CGSizeMake((array.count + 2) * self.frame.size.width,0);
            startPoint = CGPointMake(self.frame.size.width, 0);
        }
    }else{ //1张图片
        for (int i = 0; i < array.count; i ++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
//            imageView.image = [UIImage imageNamed:array[i]];
            _isWebImage==YES?[imageView sd_setImageWithURL:[NSURL URLWithString:array[i]]]:(imageView.image = [UIImage imageNamed:array[i]]);
            [self addSubview:imageView];
        }
        contentSize = CGSizeMake(self.frame.size.width, 0);
        startPoint = CGPointZero;
    }
    //开始的偏移量跟内容尺寸
    self.scrollView.contentOffset = startPoint;
    self.scrollView.contentSize = contentSize;
}


-(void)setUpPageControl:(NSArray *)array
{
    NSLog(@"scrollView-frame:%f",self.scrollView.contentOffset.x);
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.superview.backgroundColor = [UIColor redColor];
    pageControl.numberOfPages = array.count;
    //默认是0
    pageControl.currentPage = 0;
    //自动计算大小尺寸
    CGSize pageSize = [pageControl sizeForNumberOfPages:array.count];
    pageControl.bounds = CGRectMake(0, 0, pageSize.width, pageSize.height);
    pageControl.center = CGPointMake(self.center.x, self.frame.size.height - 20);
    pageControl.pageIndicatorTintColor = [UIColor brownColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
   
}

-(void)pageChange:(UIPageControl *)page
{
    NSLog(@"%zd  & %f",page.currentPage,self.bounds.size.width);
    //获取当前页面的宽度
    CGFloat x = page.currentPage * self.bounds.size.width;
    //通过设置scrollView的偏移量来滚动图像
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}


#pragma mark - Timer时间方法
-(void)startTimer
{
    if (!_duration) {
        self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }else{
        self.timer = [NSTimer timerWithTimeInterval:_duration target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)updateTimer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x  + CGRectGetWidth(self.scrollView.frame), 0);
    [self.scrollView setContentOffset:newOffset animated:YES];
}


#pragma mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.x < self.frame.size.width) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * (self.imageArray.count + 1), 0) animated:NO];
    }
    //偏移超过
    if (scrollView.contentOffset.x > self.frame.size.width * (self.imageArray.count + 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }
    int pageCount = scrollView.contentOffset.x / self.frame.size.width;
    
    if (pageCount > self.imageArray.count) {
        pageCount = 0;
    }else if (pageCount == 0){
        pageCount = (int)self.imageArray.count - 1;
    }else{
        pageCount--;
    }
    self.pageControl.currentPage = pageCount;
}

//手势点击
- (void)pageViewClick:(UITapGestureRecognizer *)tap
{
//    NSLog(@"点击了第%ld页",self.pageControl.currentPage);
    [self.delegate didSelectPageViewWithNumber:self.pageControl.currentPage];
}


//停止滚动时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}


//开始拖动时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

//结束拖动时
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

@end
