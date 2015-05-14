//
//  BBArticleShareHandler.h
//  iBloomBerg
//
//  Created by Xiangjian Meng on 12-10-9.
//
//

#import <Foundation/Foundation.h>

#import "WeiboShareHandler.h"
#import "WeixinShareHandler.h"
#import "EmailShareHandler.h"
#import "EvernoteShareHandler.h"
#import "FacebookAndTwitterShareHandler.h"
#import "PhotoAlbumShareHandler.h"
#import "CopyContentShareHandler.h"
#import "ShareActivity.h"

typedef enum : NSUInteger {
    ShareTypeEmail = 0,
    ShareTypeWeibo,
    ShareTypeWeixin,
    ShareTypeWeixinFriendCircle,
    ShareTypeLinkedIn,
    ShareTypeEvernote,
    ShareTypeFacebook,
    ShareTypeTwitter,
    ShareTypePhotoAlbum,
    ShareTypeCopyContent,
    ShareTypeReportCard
} ShareType;//分享途径

//回调方法
@protocol ShareHandlerDelegate <NSObject>
@optional

//分享成功
- (void)shareDidSuccess:(ShareType)shareType;
//分享失败
- (void)shareDidFailure:(ShareType)shareType error:(NSError *)error;

//授权成功 (目前实现只有evernote)
- (void)authorizeDidSuccess:(ShareType)shareType;
//授权失败 (目前实现只有evernote)
- (void)authorizeDidFailure:(ShareType)shareType error:(NSError *)error;

//登出成功 (目前实现只有evernote)
- (void)logoutDidSuccess:(ShareType)shareType;
//登出失败 (目前实现只有evernote)
- (void)logoutDidFailure:(ShareType)shareType;

@end


@interface ShareHandler : NSObject<EmailShareHandlerDelegate,EvernoteShareHandlerDelegate,
                            WeixinShareHandlerDelegate,WeiboShareHandlerDelegate,
                            FacebookAndTwitterShareHandlerDelegate,PhotoAlbumShareHandlerDelegate,
                            CopyContentShareHandlerDelegate>

@property (nonatomic, weak) id <ShareHandlerDelegate> delegate;


//=======================================类方法，创建单例========================================
+ (instancetype)defaultHandler;

//=======================================设置weiboEngine=================================
- (void)setWeiboAppKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectUrl:(NSString *)redirectUrl;

// ======================================设置微信的key====================================
- (void)setWeixinAppId:(NSString *)appId;

//=======================================openURL========================================
// 用于微信微博等app之间跳转,在AppDelegate的 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation 中调用
- (BOOL)handleOpenURL:(NSURL *)url;
// app 被激活时候调用 - (void)applicationDidBecomeActive:(UIApplication *)application
- (void)becomeActive;

//=======================================分享界面相关方法=========================================
//pad设备方向变化，调用方法
- (void)deviceOrientationRotateToOrientation:(UIInterfaceOrientation)toOrientation;

//新接口 分享列表UI使用REActivityViewController情况下，需要传入一个PresentingViewController，而不是一个View
- (void)showShareUserInterfaceWithPresentingViewContrller:(UIViewController *)controller
                                 shareListDataSourceArray:(NSArray *)_datasource
                                       padPopoverFromRect:(CGRect)popoverFromRect
                                 padPopoverArrowDirection:(UIPopoverArrowDirection)popoverArrowDirection;

- (void)showShareUserInterfaceWithPresentingViewController:(UIViewController *)controller
                                                 shareList:(NSArray *)shareList
                                                shareBlock:(void(^)(ShareDismissShareViewBlock dismissBlock, ShareType shareType))shareBlock
                                        padPopoverFromRect:(CGRect)popoverFromRect
                                  padPopoverArrowDirection:(UIPopoverArrowDirection)popoverArrowDirection;


//========================================各种分享方式具体分享方法==================================
/*邮件分享，
 model: 邮件分享内容的数据模型
 viewController: 发送邮件界面在其上。
*/
-(void)emailShareArticleWithMailModel:(ShareDataModelEmail *)model viewController:(UIViewController *)viewController;


/*微博分享，
 model: 微博分享内容的数据模型
 viewController: 发送微博界面在其上。
 */
-(void)weiboShareArticleWithWeiboModel:(ShareDataModelWeibo *)model viewController:(UIViewController *)viewController;


/*微信分享，
 model: 微信分享内容的数据模型
 scene: 微信分享的场景，普通和朋友圈
 */
-(void)weixinShareArticleWithWeixinModel:(ShareDataModelWeixin *)model scene:(WeixinScene)scene;


/*linkedin分享，
 model: linkedin分享内容的数据模型
 viewController: linkedin界面在其上。
 */
//-(void)linkedinShareArticleWithLinkenInModel:(ShareDataModelLinkedIn *)model viewController:(UIViewController *)viewController;

/*facebook分享，
 model: facebook分享内容的数据模型
 viewController: facebook界面在其上。
 */
-(void)facebookShareArticleWithLinkenInModel:(ShareDataModelFacebookAndTwitter *)model viewController:(UIViewController *)viewController;

/*twitter分享，
 model: twitter分享内容的数据模型
 viewController: twitter界面在其上。
 */
-(void)twitterShareArticleWithLinkenInModel:(ShareDataModelFacebookAndTwitter *)model viewController:(UIViewController *)viewController;


/*evernote分享，
 model: evernote分享内容的数据模型
 viewController: evernote界面在其上。
 */
-(void)evernoteShareArticleWithEvernoteModel:(ShareDataModelEvernote *)model event:(EvernoteNoteEvents)event viewController:(UIViewController *)viewController;

/*photoAlbum分享，
 model: photoAlbum分享内容的数据模型
 viewController: evernote界面在其上。
 */
-(void)photoAlbumShareImageWithPhotoAlbumModel:(ShareDataModelPhotoAlbum *)model;

-(void)copyContentShareContentWithCopyContentModel:(ShareDataModelCopyContent *)model;



//=======================================个别需要授权和验证的方式的额外方法==================================
// 返回是否被授权 (不需要授权的方式默认返回yes,现只支持evernote分享,其他均default YES）
- (BOOL)shareIsAuthenticatedWithShareType:(ShareType)shareType shareDataModel:(id)shareDataModel;

// 事件统计名称
- (NSString *)flurryEventWithShareType:(ShareType)sharetype;

@end
