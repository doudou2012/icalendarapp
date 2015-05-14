//
//  ShareDataModelWeixin.h
//  Share
//
//  Created by Xiangjian Meng on 13-3-7.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShareDataModelWeixin : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,strong) NSString *webUrl;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,assign) BOOL imageIsThumb;

@end
