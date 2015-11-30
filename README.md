# YPageView
封装的scrollerView轮播图， 用于广告等图片滚动播放。 支持网络和本地图片,SDWebImage加载网络图片。

#效果图：

 [![](https://github.com/yimouleng/MTPageView/blob/master/123123.gif)](https://github.com/yimouleng/MTPageView/blob/master/123123.gif)

## 使用方法

```
 //本地图片

    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",nil];

    //网络图片

//    NSArray *imageArray = @[@"http://i1.douguo.net//upload/banner/0/6/a/06e051d7378040e13af03db6d93ffbfa.jpg", @"http://i1.douguo.net//upload/banner/9/3/4/93f959b4e84ecc362c52276e96104b74.jpg", @"http://i1.douguo.net//upload/banner/5/e/3/5e228cacf18dada577269273971a86c3.jpg", @"http://i1.douguo.net//upload/banner/d/8/2/d89f438789ee1b381966c1361928cb32.jpg"];

    PageView *pageView = [[PageView alloc] initPageViewFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];

    //是否是网络图片

    pageView.isWebImage = NO;

    //存放图片数组

    pageView.imageArray = imageArray;

    //停留时间

    pageView.duration = 5.0;

    

    [self.view addSubview:pageView];
    
```

###声明

使用有问题请提问，如有BUG或者建议等，欢迎拉请求或者联系我。
