//
//  TPWebViewKeyboardController.m
//  TextProgramming
//
//  Created by QSP on 2022/11/21.
//

#import "TPWebViewKeyboardController.h"
#import <Webkit/WebKit.h>
#import "Masonry.h"

@interface TPWebViewKeyboardController ()

@end

@implementation TPWebViewKeyboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = [[WKUserContentController alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TPWebKeyBoard" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}

@end
