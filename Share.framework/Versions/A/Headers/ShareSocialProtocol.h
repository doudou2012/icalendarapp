//
//  ShareSocialProtocol.h
//  NewShare
//
//  Created by Xiangjian Meng on 13-6-8.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareDataModelWeibo.h"

typedef void (^ShareSocialProtocolSendWeiboCompleteBlock)(BOOL success);
typedef void (^ShareSocialProtocolCheckWeiboAccountBlock)(BOOL haveAccount);
typedef void (^ShareSocialProtocolAuthorizeAccountBlock)(BOOL authorized);

@protocol ShareSocialProtocol <NSObject>

- (void)authorizeWeiboAccountWithAuthorizeBlock:(ShareSocialProtocolAuthorizeAccountBlock)block;

- (void)checkExistingWeiboAccountWithBlock:(ShareSocialProtocolCheckWeiboAccountBlock)block;

- (void)sendWeiboWithWeibo:(ShareDataModelWeibo *)weibo viewController:(UIViewController *)controller completeBlock:(ShareSocialProtocolSendWeiboCompleteBlock)block;

@end
