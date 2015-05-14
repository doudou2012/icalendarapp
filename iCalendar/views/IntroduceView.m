//
//  IntroduceView.m
//  iCalendar
//
//  Created by fanzhanao on 15/4/9.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import "IntroduceView.h"

@interface IntroduceView () <UIScrollViewDelegate>
{
    NSInteger currentPage;
}

@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) UIScrollView *scrollView;
//@property (nonatomic,strong) UIPageControl *pageControl;

@end
@implementation IntroduceView

- (instancetype) initWithFrameAndArray:(CGRect)frame
                            imageArray:(NSArray*)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        currentPage = 1;
        _imageArray = imageArray;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator  =NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        
        [_scrollView setContentSize:CGSizeMake(frame.size.width*[_imageArray count], frame.size.height)];
        if ([imageArray count] > 0) {
            int i=0;
            for (NSString *imgPath in imageArray) {
                UIImageView *_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*frame.size.width, 0.f, frame.size.width, frame.size.height)];
                UIImage *img  = [UIImage imageNamed:imgPath];
                [_imgView setImage:img];
                [_scrollView addSubview:_imgView];
                ++i;
            }
        }
        [self addSubview:_scrollView];
        
//        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((frame.size.width-80.f)/2.f, frame.size.height-100.f, 80.f, 30.f)];
//        _pageControl.numberOfPages = [imageArray count];
//        [self addSubview:_pageControl];
    }
    return self;
}


#pragma mark
#pragma mark UIScrollViewDelegate method
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    int size  = self.frame.size.width;
//    int page = _scrollView.contentOffset.x/size;
//    _pageControl.currentPage = page;
    if (_scrollView.contentOffset.x-20.f > self.bounds.size.width*([_imageArray count]-1)) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didScrolled)]) {
            [self.delegate didScrolled];
        }
        [UIView animateWithDuration:0.4f animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
