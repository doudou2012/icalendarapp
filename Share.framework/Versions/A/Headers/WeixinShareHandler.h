//
//  BBArticleWeixinShareHandler.h
//  iBloomBerg
//
//  Created by Xiangjian Meng on 12-10-9.
//
//

#import <Foundation/Foundation.h>

#import "ShareDataModelWeixin.h"

typedef enum {
    WeixinSceneDefault = 0,
    WeixinSceneFriendCircle,
}WeixinScene;

@protocol WeixinShareHandlerDelegate <NSObject>

- (void)weixinShareSuccess:(WeixinScene)scene;

- (void)weixinShareFailure:(WeixinScene)scene;

@end



@interface WeixinShareHandler : NSObject

@property (nonatomic,weak) id <WeixinShareHandlerDelegate> delegate;

+ (WeixinShareHandler *)defaultHandler;

- (void)shareArticleViaWeixinWithModel:(ShareDataModelWeixin *)weixin scene:(WeixinScene)scene;

- (void)registerApp:(NSString *)weixinAppid;

- (BOOL)handleOpenURL:(NSURL *)url;

@end
