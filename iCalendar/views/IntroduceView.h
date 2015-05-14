//
//  IntroduceView.h
//  iCalendar
//
//  Created by fanzhanao on 15/4/9.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroduceDelegate <NSObject>

- (void) didScrolled;

@end

@interface IntroduceView : UIView

@property (nonatomic,assign) id<IntroduceDelegate> delegate;

- (instancetype) initWithFrameAndArray:(CGRect)frame
                            imageArray:(NSArray*)imageArray;
@end
