//
//  CopyContentShareHandler.h
//  Share
//
//  Created by Xiangjian Meng on 13-11-26.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareDataModelCopyContent.h"

@protocol CopyContentShareHandlerDelegate <NSObject>

- (void)copyContentSuccess;

@end

@interface CopyContentShareHandler : NSObject

@property (nonatomic, weak) id <CopyContentShareHandlerDelegate> delegate;

+(CopyContentShareHandler *)defaultHandler;


- (void)shareContentViaCopyContentModel:(ShareDataModelCopyContent *)content;

@end
