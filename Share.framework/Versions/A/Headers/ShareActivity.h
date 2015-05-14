//
//  ShareActivity.h
//  Share
//
//  Created by Xiangjian Meng on 13-7-3.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//


//此类的功能就是提供外面人用的Activity，代表分享列表中的一个分享元素，代替原来的sharelistItemModel。

#import <Foundation/Foundation.h>

@class ShareActivity;

typedef void (^ShareDismissShareViewBlock)(void(^dismissComplete)(void));

typedef void (^ShareActivityActionBlock)(ShareActivity *shareActivity, ShareDismissShareViewBlock dismissBlock);


@interface ShareActivity : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) ShareActivityActionBlock actionBlock;

- (id)initWithTitle:(NSString *)_title image:(UIImage *)_image actionBlock:(ShareActivityActionBlock)_actionBlock;

@end


