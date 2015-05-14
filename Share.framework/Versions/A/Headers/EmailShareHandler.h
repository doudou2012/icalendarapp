//
//  BBArticleEmailShareHandler.h
//  iBloomBerg
//
//  Created by Xiangjian Meng on 12-10-9.
//
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
//#import "BBArticleShareHandler.h"
#import "ShareDataModelEmail.h"

@protocol EmailShareHandlerDelegate <NSObject>

- (void)emailShareSuccess;

- (void)emailShareFailure;

@end

@interface EmailShareHandler : NSObject <MFMailComposeViewControllerDelegate>

@property (nonatomic,weak) id <EmailShareHandlerDelegate> delegate;


+(EmailShareHandler *)defaultHandler;

//旧接口
//-(void)shareArticleViaEmailWithIssueid:(NSString *)aIssueid columnid:(NSString *)aColumnid articleid:(NSString *)aArticleid viewController:(UIViewController *)aViewController;


//新接口
- (void)shareArticleViaEmailModel:(ShareDataModelEmail *)email viewController:(id)aViewController;

@end
