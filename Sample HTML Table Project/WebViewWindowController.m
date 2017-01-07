//
//  WebViewWindowController.m
//  Sample HTML Table Project
//
//  Created by ANTHONY CRUZ on 1/7/17.
//  Copyright © 2017 Writes for All Inc. All rights reserved.
//

#import "WebViewWindowController.h"
#import <WebKit/WebKit.h>

@interface WebViewWindowController ()

@property (weak) IBOutlet WebView *webView;

@end

@implementation WebViewWindowController

-(instancetype)initWithHTMLString:(NSString*)htmlString
{
    self = [super initWithWindowNibName:NSStringFromClass([WebViewWindowController class])];
    if (self)
    {
        _htmlString = htmlString;
    }
    return self;
}

-(void)windowDidLoad
{
    [super windowDidLoad];
    [self.webView.mainFrame loadHTMLString:self.htmlString baseURL:nil];
}

-(void)setHtmlString:(NSString *)htmlString
{
    if (![_htmlString isEqualToString:htmlString])
    {
        _htmlString = htmlString;
        if (self.isWindowLoaded)
        {
            [self.webView.mainFrame loadHTMLString:htmlString baseURL:nil];
        }
    }
}

-(IBAction)doneButtonAction:(id)sender
{
    [self.delegate webViewWindowControllerDidFinish:self];
}

@end
