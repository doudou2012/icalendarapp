//
//  EvernoteShareHelper.h
//  Slate
//
//  Created by Xiangjian Meng on 13-4-1.
//  Copyright (c) 2013年 yizelin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShareHandler.h"

extern NSString* const EvernoteShareHelperEnableShareArticleChangedNotification;
extern NSString* const EvernoteShareHelperEnableShareCardChangedNotification;

@interface EvernoteShareHelper : NSObject <ShareHandlerDelegate>

@property (nonatomic, strong) NSString *evernoteAppKey;
@property (nonatomic, strong) NSString *evernoteAppSecret;
@property (nonatomic, strong) NSString *evernoteHost;

+ (instancetype)sharedHelper;

//=================================== 对外接口 ================================
// 激活卡片evernote分享
- (void)authorizeEvernoteForShareCard;

// 激活文章evernote分享
- (void)authorizeEvernoteForShareArticle;

// 同步收藏文章或evernote分享文章
- (void)evernoteShareArticleWithTitle:(NSString *)title
                              content:(NSString *)content
                               weburl:(NSString *)weburl
                                 tags:(NSMutableArray *)tags;
// 同步收藏笔记
- (void)evernoteShareCardWithCardTitle:(NSString *)title cardContent:(NSString *)content cardWeburl:(NSString *)weburl;

// evernote 登出
- (void)evernoteLogout;

- (void)setShareArticleEnabled:(BOOL)enabled;
- (BOOL)shareArticleEnabled;

- (void)setShareCardEnabled:(BOOL)enabled;
- (BOOL)shareCardEnabled;

@end
