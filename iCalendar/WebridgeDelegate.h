//
//  WebridgeDelegate.h
//  Webridge
//
//  Created by fanzhanao on 15/3/16.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WBWebridge.h"

@interface WebridgeDelegate : NSObject <WBWebridgeDelegate>

@property (nonatomic, copy) void(^domReadyBlock)(void);
@end
