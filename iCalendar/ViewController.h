//
//  ViewController.h
//  iCalendar
//
//  Created by fanzhanao on 15/3/16.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBURI.h"
#import "WBUIWebView.h"
#import "WBWebridge.h"
#import "WebridgeDelegate.h"

typedef void (^WebViewFinishedBlock)(void);

@interface ViewController : UIViewController
@property (nonatomic, strong) WBUIWebView *webView;
@property (nonatomic, strong) WebridgeDelegate *webridgeDelegate;
@property (nonatomic, assign) BOOL webViewLoaded;
@property (nonatomic, copy) WebViewFinishedBlock webViewFinishedBlock;

@end

