//
//  WebViewWindowController.h
//  Sample HTML Table Project
//
//  Created by ANTHONY CRUZ on 1/7/17.
//  Copyright © 2017 Writes for All Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol WebViewWindowControllerDelegate;

@interface WebViewWindowController : NSWindowController

-(nonnull instancetype)initWithHTMLString:(nonnull NSString*)htmlString;

@property (nonnull,nonatomic,strong) NSString *htmlString;

@property (nullable,weak) id <WebViewWindowControllerDelegate> delegate;

@end

@protocol WebViewWindowControllerDelegate <NSObject>

-(void)webViewWindowControllerDidFinish:(nonnull WebViewWindowController*)windowController;

@end
