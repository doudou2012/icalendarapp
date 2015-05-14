//
//  ShareDataModelEvernote.h
//  Share
//
//  Created by Xiangjian Meng on 13-3-7.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareDataModelEvernote : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *sourceUrl;
@property (nonatomic,strong) NSMutableArray *tags;

@property (nonatomic,strong) NSString *consumerKey;
@property (nonatomic,strong) NSString *consumerSecret;
@property (nonatomic,strong) NSString *authorizeUrlHost;


- (id)initWithConsumerKey:(NSString *)key consumerSecret:(NSString *)secret authorizeUrlHost:(NSString *)host;

@end
