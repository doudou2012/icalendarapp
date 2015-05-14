//
//  WebridgeDelegate.m
//  Webridge
//
//  Created by fanzhanao on 15/3/16.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import "WebridgeDelegate.h"
#import <Share/Share.h>
#import "MBProgressHUD.h"

@interface WebridgeDelegate () <ShareHandlerDelegate>{
    NSMutableArray *shareArray;
    NSDictionary *shareParam;
}

@property (nonatomic, strong) NSMutableDictionary *contacts;

@end

@implementation WebridgeDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        shareArray = [[NSMutableArray alloc] init];
        shareParam = [[NSDictionary alloc] init];
    }
    return self;
}

/**
 * dom树加载完成
 */
- (void)domReady:(id)params
{
    if (self.domReadyBlock) {
        self.domReadyBlock();
    }
}

/**
 * 分享内容
 */
- (void) shared:(id) params
       completion:(WBWebridgeCompletionBlock)completion
{
    shareParam = (NSDictionary*)params;
    UIViewController *controller = [[UIApplication sharedApplication] keyWindow].rootViewController;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShareList" ofType:@"plist"];
    NSArray *shareList = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"shareList_iphone"];
    [[ShareHandler defaultHandler] showShareUserInterfaceWithPresentingViewController:controller
                                                                            shareList:shareList
                                                                           shareBlock:^(ShareDismissShareViewBlock dismissBlock, ShareType shareType) {
                                                                               [self shareWithShareType:shareType
                                                                                           dismissBlock:dismissBlock];
                                                                           }
                                                                   padPopoverFromRect:CGRectZero
                                                             padPopoverArrowDirection:UIPopoverArrowDirectionRight];

}

- (void)shareWithShareType:(ShareType)shareType
              dismissBlock:(ShareDismissShareViewBlock)dismissBlock
{
    switch (shareType)
    {
        case ShareTypeEmail:
            [self shareEmail:dismissBlock ];
            break;
        case ShareTypeWeibo:
            [self shareWeibo:dismissBlock];
            break;
        case ShareTypeWeixin:
            [self shareWeixin:WeixinSceneDefault block:dismissBlock];
            break;
        case ShareTypeWeixinFriendCircle:
            [self shareWeixin:WeixinSceneFriendCircle block:dismissBlock];
            break;
        case ShareTypeFacebook:
            [self shareFBTW:YES block:dismissBlock];
            break;
        case ShareTypeTwitter:
            [self shareFBTW:NO block:dismissBlock];
            break;
        default:
            break;
    }
}
/**
 * 邮件分享
 */
- (void) shareEmail:(ShareDismissShareViewBlock)block
{
    ShareDataModelEmail *email = [[ShareDataModelEmail alloc] init];
    if ([shareParam objectForKey:@"title"]) {
        email.title = [shareParam objectForKey:@"title"];
//        if ([shareParam objectForKey:@"content"]) {
//            email.content  = [shareParam objectForKey:@"content"];
//        }
        email.content  =  [NSString stringWithFormat:@"<a href=\"%@\" >%@</a>",[shareParam objectForKey:@"url"],email.title ];
    }
    
    // block这样使用
    if (block)
    {
        __weak typeof(self) weakSelf = self;
        void(^dismissComplete)(void) = ^ {
            // 设置代理对象
            [[ShareHandler defaultHandler] setDelegate:weakSelf];
            // 微博分享方法
            [[EmailShareHandler defaultHandler] shareArticleViaEmailModel:email viewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
        };
        block(dismissComplete);
    }
}
/**
 * 微博分享
 */
- (void) shareWeibo:(ShareDismissShareViewBlock)block
{
    ShareDataModelWeibo *shareModelWB = [[ShareDataModelWeibo alloc] init];
    shareModelWB.content = [ shareParam objectForKey:@"title"];
    if ([shareParam objectForKey:@"url"]) {
        shareModelWB.url = [shareParam objectForKey:@"url"];
    }
    // block这样使用
    if (block)
    {
        __weak typeof(self) weakSelf = self;
        void(^dismissComplete)(void) = ^ {
            // 设置代理对象
            [[ShareHandler defaultHandler] setDelegate:weakSelf];
            // 微博分享方法
            [[WeiboShareHandler defaultHandler] shareArticleViaWeiboWithModel:shareModelWB viewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
        };
        block(dismissComplete);
    }
}
/**
 * 微信分享
 */
- (void) shareWeixin:(WeixinScene)scene
               block:(ShareDismissShareViewBlock)block
{
    ShareDataModelWeixin *shareModelWX = [[ShareDataModelWeixin alloc] init];
    shareModelWX.title = [shareParam objectForKey:@"title"];
    if ([shareParam objectForKey:@"url"]) {
        shareModelWX.webUrl = [shareParam objectForKey:@"url"];
    }
    if ([shareParam objectForKey:@"content"]) {
        shareModelWX.desc = [shareParam objectForKey:@"content"];
    }
    shareModelWX.image = [UIImage imageNamed:@"Icon-wx.png"];
    shareModelWX.imageIsThumb = YES;
    if (block)
    {
        __weak typeof(self) weakSelf = self;
        void(^dismissComplete)(void) = ^ {
            // 设置代理对象
            [[ShareHandler defaultHandler] setDelegate:weakSelf];
            // 微博分享方法
            [[WeixinShareHandler defaultHandler] shareArticleViaWeixinWithModel:shareModelWX scene:scene];
        };
        block(dismissComplete);
    }
    
}
/**
 * facebook Twiiter Share
 */
- (void) shareFBTW:(BOOL)isFaceBook
             block:(ShareDismissShareViewBlock)block{
    ShareDataModelFacebookAndTwitter *ftModel = [[ShareDataModelFacebookAndTwitter alloc] init];
    ftModel.content = [shareParam objectForKey:@"title"];
    ftModel.url =[shareParam objectForKey:@"url"];
    if (block)
    {
        __weak typeof(self) weakSelf = self;
        void(^dismissComplete)(void) = ^ {
            // 设置代理对象
            [[ShareHandler defaultHandler] setDelegate:weakSelf];
            // 微博分享方法
            [[FacebookAndTwitterShareHandler defaultHandler] shareArticleViaFacebookAndTwitter:ftModel viewController:[[UIApplication sharedApplication] keyWindow].rootViewController isFaceBookShareFlag:isFaceBook];
        };
        block(dismissComplete);
    }
    
}

#pragma mark -
#pragma mark ShareHandlerDelegate
//分享成功
- (void)shareDidSuccess:(ShareType)shareType
{
    MBProgressHUD *_hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow].rootViewController.view animated:YES];
    _hud.labelText = @"分享成功!";
    [_hud show:YES];
    [_hud hide:YES afterDelay:2.f];
}

//分享失败
- (void)shareDidFailure:(ShareType)shareType error:(NSError *)error
{
    MBProgressHUD *_hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow].rootViewController.view animated:YES];
    _hud.labelText = @"分享失败，请稍后再试!";
    [_hud show:YES];
    [_hud hide:YES afterDelay:2.f];
}



@end
