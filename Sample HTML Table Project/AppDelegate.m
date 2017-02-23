//
//  AppDelegate.m
//  Sample HTML Table Project
//
//  Created by ANTHONY CRUZ on 1/7/17.
//  Copyright © 2017 Writes for All Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "ATHyperTextTableView.h"
#import "AppObject.h"
#import "WebViewWindowController.h"

@interface AppDelegate () <ATHyperTextTableViewDataSource,NSTableViewDelegate,WebViewWindowControllerDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet ATHyperTextTableView *tableView;

@property (strong) NSArray <AppObject*>*apps;
@property (strong) WebViewWindowController *webViewWindowController;

@end

@implementation AppDelegate

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _apps = @[[AppObject fileCabinetPro],
                  [AppObject desktopGhostPro],
                  [AppObject visualAttributedString],
                  [AppObject rawDogXMLViewer],
                  [AppObject pdfImageXtractor],
                  [AppObject wordCounterPro]];
    }
    return self;
}

-(void)applicationDidFinishLaunching:(NSNotification*)aNotification
{
    // Insert code here to initialize your application
}


#pragma mark - ATHyperTextTableViewDataSource
-(NSInteger)numberOfRowsInTableView:(NSTableView*)tableView
{
    return self.apps.count;
}

-(NSView*)tableView:(NSTableView*)tableView
 viewForTableColumn:(NSTableColumn*)tableColumn
                row:(NSInteger)row
{
    static NSString *CellID = @"CellIdentifier";
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:CellID owner:self];
    cellView.textField.stringValue = [self titleForViewInTableColumn:tableColumn inRow:row isHTML:NO];
    return cellView;
}

-(NSString*)titleForViewInTableColumn:(NSTableColumn*)column
                                inRow:(NSInteger)row
                               isHTML:(BOOL)isHTML
{
    if ([column.title isEqualToString:@"App Names"])
    {
        return [self.apps objectAtIndex:row].name;
    }
    else if ([column.title isEqualToString:@"Categories"])
    {
         return [self.apps objectAtIndex:row].category;
    }
    else if ([column.title isEqualToString:@"SKU"])
    {
         return [self.apps objectAtIndex:row].sku;
    }
    else if ([column.title isEqualToString:@"Website"])
    {
        NSString *webAddress = [self.apps objectAtIndex:row].websiteAddress;
        
        if (isHTML)
        {
            NSString *link = [NSString stringWithFormat:@"<a href=\"%@\">%@</a>",
                              webAddress,webAddress];
            return link;
        }
        else
        {
            return webAddress;
        }
    }
    else
    {
        return @"";
    }
}

-(NSString*)tableView:(ATHyperTextTableView*)tableView
 titleForHTMLTableRow:(NSInteger)row
             inColumn:(NSInteger)column
{
    return [self titleForViewInTableColumn:[tableView.tableColumns objectAtIndex:column]
                                     inRow:row
                                    isHTML:YES];
}

#pragma mark - IBActions
-(IBAction)showHTMLTableButtonAction:(id)sender
{
    self.webViewWindowController = [[WebViewWindowController alloc]initWithHTMLString:self.tableView.htmlRepresentation];
    self.webViewWindowController.delegate = self;
    [self.window beginSheet:self.webViewWindowController.window completionHandler:nil];
}

-(IBAction)useCustomStylesCheckboxAction:(NSButton*)sender
{
    if (sender.state == NSOnState)
    {
        //Would be nicer to load this string in from a file on the main bundle, but will just use a string literal for the purposes of this demo.
        self.tableView.cssForHtmlRepresentation = @"table {font-size:12px; color:#333333; width:100%%; border-width:1px; border-color:#729ea5; border-collapse:collapse;} th { font-size:12px; background-color:#acc8cc; border-width:1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align:left;} td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;} tr {background-color:#d4e3e5;}";
    }
    else
    {
        self.tableView.cssForHtmlRepresentation = nil;
    }
}

#pragma mark - WebViewWindowControllerDelegate
-(void)webViewWindowControllerDidFinish:(WebViewWindowController*)windowController
{
    [self.window endSheet:windowController.window];
    self.webViewWindowController = nil;
}

@end
