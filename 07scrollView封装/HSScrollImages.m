//
//  HSScrollImages.m
//  07scrollView封装
//
//  Created by 郝帅 on 16/1/28.
//
//

#import "HSScrollImages.h"

@interface HSScrollImages()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, weak) NSTimer *timer;


@end

@implementation HSScrollImages
+ (instancetype)scrollImages
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    self.pageControl.hidesForSinglePage = YES;
//    [self startTimer];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.imageNames.count; ++i) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGRect Frame = imageView.frame;
        Frame.origin.x = i * self.scrollView.frame.size.width;
        imageView.frame = Frame;
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.imageNames.count, 0);
}

- (void)setImageNames:(NSArray<NSString *> *)imageNames
{
    _imageNames = imageNames;
    
    //先移除所有的imageView;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    for (int i = 0; i < imageNames.count; ++i) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageNames[i]]];
        //imageView的autoresingMask 跟随父控件变化
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        imageView.frame = CGRectMake(width * i, 0, width, height);
        [self.scrollView addSubview:imageView];
    }
    //设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * imageNames.count, 0);
    self.pageControl.numberOfPages = self.imageNames.count;
    
}
//定时器相关代码
- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage:) userInfo:@"123" repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
}

- (void)nextPage:(NSTimer *)timer
{
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == self.imageNames.count) {
        page = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0) animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 计算页码
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = page;
}


// 用户开始拖拽scrollView时,停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

// 用户停止拖拽scrollView时,开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

@end
