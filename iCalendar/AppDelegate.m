//
//  AppDelegate.m
//  iCalendar
//
//  Created by fanzhanao on 15/3/16.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import "AppDelegate.h"
#import "WBReachability.h"

@interface AppDelegate ()
{
    UIWebView *webview;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [application setStatusBarHidden:YES];
//    [WBReachability sharedReachability];
//    if (!webview) {
//        webview = [[UIWebView alloc] initWithFrame:CGRectZero];
//        NSString *oldAgent = [webview stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//        NSString *newAgent = [oldAgent stringByAppendingString:@"iArt Calendar"];
//        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
//        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
//    }
    [self shareConfig];
    return YES;
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[ShareHandler defaultHandler] becomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[ShareHandler defaultHandler] handleOpenURL:url];
}

- (void) shareConfig
{
    [[ShareHandler defaultHandler] setWeiboAppKey:kWeiboAppKey
                                        appSecret:kWeiboAppSecret
                                      redirectUrl:kWeiboRedirectUrl];
    
    [[ShareHandler defaultHandler] setWeixinAppId:kWeixinAppId];
    
//    [SlateCommunity setWeiboAppKey:@"1805194978" appSecret:@"47412982ce372eb6c98a11ca29ee2453" redirectUrl:@"http://fake.url"];
//    [SlateCommunity setQQAppId:@"101082784"];
//    [SlateCommunity setWeixinAppId:@"wx9ecedeef28d09f2d"];
}

@end
