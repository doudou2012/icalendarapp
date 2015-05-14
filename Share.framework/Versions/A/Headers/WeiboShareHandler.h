//
//  BBArticleWeiboShareHandler.h
//  iBloomBerg
//
//  Created by Xiangjian Meng on 12-8-21.
//  Copyright (c) 2012年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
//#import "BBArticleShareHandler.h
#import "ShareSocialProtocol.h"
//#import "WBEngine.h"

@protocol WeiboShareHandlerDelegate <NSObject>

- (void)weiboShareSuccess;

- (void)weiboShareFailure;

@end

@interface WeiboShareHandler : NSObject

//@property (nonatomic,strong) NSString *weiboAppKey;
//@property (nonatomic,strong) NSString *weiboAppSecret;
@property (nonatomic,weak) id <WeiboShareHandlerDelegate> delegate;
@property (nonatomic,weak) id <ShareSocialProtocol> wbEngine;

+(WeiboShareHandler *)defaultHandler;

//-(void)shareArticleViaWeiboWithIssueid:(NSString *)aIssueid columnid:(NSString *)aColumnid articleid:(NSString *)aArticleid viewController:(UIViewController *)aViewController;

-(void)shareArticleViaWeiboWithModel:(ShareDataModelWeibo *)weibo viewController:(UIViewController *)aViewController;

//- (BOOL)weiboIsAuthenticatedWithModel:(ShareDataModelWeibo *)model;


@end
