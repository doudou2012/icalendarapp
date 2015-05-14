//
//  BBArticleEvernoteShareHandler.h
//  iBloomBerg
//
//  Created by Xiangjian Meng on 12-11-27.
//
//

#import "ShareDataModelEvernote.h"

typedef enum
{
    EvernoteNoteEventLogin,
    EvernoteNoteEventLogout,
    EvernoteNoteEventShare,
} EvernoteNoteEvents;


@protocol EvernoteShareHandlerDelegate <NSObject>

- (void)evernoteShareSuccess;

- (void)evernoteShareFailure:(NSError *)error;

- (void)evernoteAuthorizeSuccess;

- (void)evernoteAuthorizeFailure:(NSError *)error;

- (void)evernoteLogoutSuccess;

- (void)evernoteLogoutFailure;

@end

@interface EvernoteShareHandler : NSObject

@property (nonatomic,weak) id <EvernoteShareHandlerDelegate> delegate;

+(EvernoteShareHandler *)defaultHandler;

- (void)evernoteLogout:(ShareDataModelEvernote *)evernote;

- (BOOL)evernoteIsAuthenticatedWithModel:(ShareDataModelEvernote *)model;

//最新的接口
- (void)authorizeEvernote:(UIViewController *)controller
           EvernoteEvents:(EvernoteNoteEvents)evernoteAction
                 note:(ShareDataModelEvernote *)evernote;

@end
