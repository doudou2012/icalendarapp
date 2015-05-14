//
//  ViewController.m
//  iCalendar
//
//  Created by fanzhanao on 15/3/16.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"
#import "IntroduceView.h"
#import "MBProgressHUD.h"

const static NSTimeInterval timeInterval = 30.f;//30s 超时
static NSString * const host = @"http://106.186.123.223/icalendar";
static NSString * const kFirstUsege = @"first_time_use";

@interface ViewController () <WKNavigationDelegate,UIWebViewDelegate,IntroduceDelegate>
{
    NSString *_ua;
    NSTimer *timer;
    BOOL is404Page;
    NSString *_currentURL;
    UIImageView *_loadingCover;//加载过程中的图片
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    __weak typeof(self) weakSelf = self;
    
    _webViewLoaded = NO;
    _webridgeDelegate = [WebridgeDelegate new];
    
    // dom加载完成的处理
    _webridgeDelegate.domReadyBlock = ^{
        [weakSelf hideHud];
        [weakSelf hideLodingCover];
    };
    
    self.webView = [[WBUIWebView alloc] initWithFrame:self.view.bounds];
    [self.webView setWebridgeDelegate:_webridgeDelegate];
    [self.webView setBackgroundColor:[UIColor colorWithRed:250/255.f green:250/255.f blue:250/255.f alpha:1.f]];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:host];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    _currentURL = host;
    [self.webView loadRequest:request];
    
    [self showIntroduceView];
}

- (void) showIntroduceView
{
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:kFirstUsege];
    if (!isFirst) {
        NSArray *image = [NSArray arrayWithObjects:@"introduce1.png",@"introduce2.png",@"introduce3.png", nil];
        IntroduceView *introduceView = [[IntroduceView alloc] initWithFrameAndArray:self.view.bounds imageArray:image];
        self.webView.hidden = YES;
        introduceView.delegate = self;
        [self.view addSubview:introduceView];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstUsege];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void) tapToReload:(UITapGestureRecognizer*)gesture
{
    [self.webView loadRequest:self.webView.request];
}
- (void) showLoadingCover
{
    if (_loadingCover) {
        @try {
            [_loadingCover removeFromSuperview];
        }
        @catch (NSException *exception) {
            NSLog(@"error is:%@",exception);
        }
        
    }
    _loadingCover =  [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f,self.view.bounds.size.width ,self.view.bounds.size.width)];
    _loadingCover.userInteractionEnabled = YES;
    [_loadingCover setImage:[UIImage imageNamed:@"global-bg.png" ]];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToReload:)];
    [_loadingCover addGestureRecognizer:gesture];
    _loadingCover.alpha = 1.f;
    [self.view addSubview:_loadingCover];
    
    self.webView.hidden  = YES;
}

- (void) hideLodingCover
{
    self.webView.hidden = NO;
    if (_loadingCover) {
        [UIView animateWithDuration:0.4f animations:^{
            _loadingCover.alpha = 0.f;
        } completion:^(BOOL finished) {
            [_loadingCover removeFromSuperview];
        }];
    }
}

- (void) stopLoadingPage
{
    [self.webView stopLoading];
    MBProgressHUD *_hud = [MBProgressHUD HUDForView:self.view];
    if (_hud) {
        _hud.labelText = @"您的网络不好，请稍后再试";
        [_hud hide:YES afterDelay:2.f];
    }
}

- (void) load404Page
{
    is404Page = YES;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"404" ofType:@"html"];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadRequest:[NSURLRequest requestWithURL:baseURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *url = navigationAction.request.URL;
    if ([WBURI canOpenURI:url]) {
        if (decisionHandler) {
            [WBURI openURI:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if (!navigationAction.targetFrame) {
        UIApplication *app = [UIApplication sharedApplication];
        if ([app canOpenURL:url]) {
            [app openURL:url];
            if (decisionHandler) {
                decisionHandler(WKNavigationActionPolicyCancel);
            }
            return;
        }
    }
    if (decisionHandler) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    _webViewLoaded = YES;
    if (self.webViewFinishedBlock) {
        self.webViewFinishedBlock();
    }
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //开启倒计时
    timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                             target:self
                                           selector:@selector(stopLoadingPage)
                                           userInfo:nil
                                            repeats:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //移除倒计时
    [timer invalidate];
    [self hideHud];
    [self hideLodingCover];
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none'; document.body.style.KhtmlUserSelect='none'"];
}

- (void) hideHud{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // todo: stopAnimating  and  showError / retry button
    [self hideHud];
//    [self showLoadingCover];
//    MBProgressHUD *_hud = [MBProgressHUD HUDForView:self.view];
//    if (_hud) {
//        _hud.labelText = @"数据加载失败，请稍后再试";
//        [_hud hide:YES afterDelay:1.f];
//    }
//    if (_loadingCover) {
//        [self.view bringSubviewToFront:_loadingCover];
//    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL    clickNavType = (navigationType == UIWebViewNavigationTypeLinkClicked);
    BOOL    otherNavType = (navigationType == UIWebViewNavigationTypeOther);
    
    if (request.URL.fragment && webView.request.mainDocumentURL)
    {
        NSURL *oldURL = [[NSURL alloc] initWithScheme:webView.request.mainDocumentURL.scheme host:webView.request.mainDocumentURL.host path:webView.request.mainDocumentURL.path];
        NSURL *anchorURL = [[NSURL alloc] initWithScheme:request.URL.scheme host:request.URL.host path:request.URL.path];
        if ([oldURL.absoluteString isEqualToString:anchorURL.absoluteString])
        {
            // 打开本页锚点  linyize 2014.09.15
            return YES;
        }
    }
    
    if (clickNavType || otherNavType)
    {
//        if ([[request.URL.scheme lowercaseString] isEqualToString:@"domloaded"]) {
//            [self hideHud];
//            [self hideLodingCover];
//            return YES;
//        }
        if ([[request.URL.scheme lowercaseString] isEqualToString:@"tel"])
        {
            // 拨打电话
            return YES;
        }
        
        if ([[request.URL.scheme lowercaseString] isEqualToString:@"mailto"])
        {
            // todo: 写邮件
            return NO;
        }
        
        if ([[request.URL.host lowercaseString] isEqualToString:@"itunes.apple.com"])
        {
            // 苹果商店链接
            [[UIApplication sharedApplication] openURL:request.URL];
            return NO;
        }
        
        if (otherNavType && [self.webView isiFrameURL:request.URL])
        {
            // 加载iframe
            return YES;
        }
        
        if ([self.webView isWebridgeMessage:request.URL])
        {
            // webridge 消息
            [self.webView handleWebridgeMessage:request.URL];
            return NO;
        }
        
        if ([WBURI canOpenURI:request.URL])
        {
            // 自定义uri
            [WBURI openURI:request.URL];
            return NO;
        }
    }
    
    return YES;
}

- (void) didScrolled
{
    self.webView.hidden = NO;
}


@end
