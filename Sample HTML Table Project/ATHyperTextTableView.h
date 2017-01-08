//  ATHyperTextTableView.h
//  Created by ANTHONY CRUZ on 1/7/17.
//  Sample HTML Table Project
//  Copyright (c) 2017 Writes for All Inc.
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import <Cocoa/Cocoa.h>

@class ATHyperTextTableView;

@protocol ATHyperTextTableViewDataSource <NSTableViewDataSource>

@optional
/**
Datasource can return the contents of the <td> element at the given row/column for the table view's htmlRepresentation.
 */
-(nullable NSString*)tableView:(nonnull ATHyperTextTableView*)tableView
          titleForHTMLTableRow:(NSInteger)row
                      inColumn:(NSInteger)column;

@end

@interface ATHyperTextTableView : NSTableView

/**
Return an html string representation of the table view's contents.
 */
@property (nonnull,copy,nonatomic,readonly) NSString *htmlRepresentation;

/**
You can set this property to customize the CSS used in htmlRepresentation. 
 */
@property (null_resettable,strong,nonatomic) NSString *cssForHtmlRepresentation;

/**
 The ATHyperTextTableViewDataSource.
 */
@property (nullable,weak) id <ATHyperTextTableViewDataSource> dataSource;

@end
