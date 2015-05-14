//
//  FacebookAndTwitterShareHandler.h
//  Share
//
//  Created by Xiangjian Meng on 13-7-2.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShareDataModelFacebookAndTwitter.h"

@protocol FacebookAndTwitterShareHandlerDelegate <NSObject>

- (void)facebookAndTwitterShareSuccessWithIsFacebookShareFlag:(BOOL)isFacebook;

- (void)facebookAndTwitterShareFailureWithIsFacebookShareFlag:(BOOL)isFacebook;

@end



@interface FacebookAndTwitterShareHandler : NSObject

@property (nonatomic, weak) id <FacebookAndTwitterShareHandlerDelegate> delegate;

+(FacebookAndTwitterShareHandler *)defaultHandler;

- (void)shareArticleViaFacebookAndTwitter:(ShareDataModelFacebookAndTwitter *)email viewController:(id)aViewController isFaceBookShareFlag:(BOOL)isFacebook;

@end
