//  ATHyperTextTableView.m
//  Created by ANTHONY CRUZ on 1/7/17.
//  Copyright (c) 2017 Writes for All Inc.
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "ATHyperTextTableView.h"
#import "ATLog.h"

@interface ATHyperTextTableView()

@property (strong,readonly) NSString *defaultCssStyle;

@end

@implementation ATHyperTextTableView
@dynamic dataSource;

-(void)_setUpOnInit
{
    _defaultCssStyle = [NSString stringWithFormat:@"table { border: solid black 1px; }\n"
                        "th,td { text-align: center; border: solid black 1px; }"];
    _cssForHtmlRepresentation = _defaultCssStyle;
}

-(instancetype)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self)
    {
        [self _setUpOnInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self _setUpOnInit];
    }
    return self;
}

-(NSString*)htmlRepresentation
{
    if (self.numberOfRows == 0
        || self.numberOfColumns == 0)
    {
        return @"";
    }
    
    NSString *title = self.window.title;
    if (title == nil) { title = @""; }
    
    NSString *styleTag = [NSString stringWithFormat:@"<style>%@</style>",self.cssForHtmlRepresentation];
    
    NSString *openingHTML = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><title>%@</title>%@</head><body>",
                             title,
                             styleTag];
    
    NSString *closingHTML = @"</body></html>";
    
    NSMutableString *htmlString = [[NSMutableString alloc]initWithString:openingHTML];
    NSMutableString *tableHTML = [[NSMutableString alloc]initWithString:@"<table>"];
    
    //Loop through table columns for table headings if we have a headerView.
    if (self.headerView != nil)
    {
        [tableHTML appendString:@"<tr>"];
        
        for (NSTableColumn *aColumn in self.tableColumns)
        {
            if (!aColumn.isHidden)
            {
                [tableHTML appendFormat:@"<th>%@</th>",aColumn.title];
            }
        }
        //Close the table row for the columns.
        [tableHTML appendString:@"</tr>"];
    }
    
    BOOL dipThroughRowsAndColumns = YES;
    NSInteger currentColumn = 0;
    NSInteger currentRow = 0;
    
    [tableHTML appendString:@"<tr>"];
    BOOL dataSourceImplementsTitleForHTMLRow = [self.dataSource respondsToSelector:@selector(tableView:titleForHTMLTableRow:inColumn:)];
    
    while (dipThroughRowsAndColumns)
    {
        NSTableColumn *tableColumn = [self.tableColumns objectAtIndex:currentColumn];
        
        if (tableColumn.isHidden)
        {
            //ATLog(@"Skip hidden column: %@",tableColumn.title);
            currentColumn++;
        }
        else if (dataSourceImplementsTitleForHTMLRow)
        {
            NSString *content = [self.dataSource tableView:self titleForHTMLTableRow:currentRow inColumn:currentColumn];
            if (content == nil) { content = @""; }
            [tableHTML appendFormat:@"<td>%@</td>",content];
            currentColumn++;
        }
        else
        {
            //Datasource didn't implement tableView:titleForHTMLTableRow:inColumn:
            //Attempt to get the title from the cell view.
            NSTableCellView *cellView = [self viewAtColumn:currentColumn
                                                       row:currentRow makeIfNecessary:YES];
            
            if ([cellView isKindOfClass:[NSTableCellView class]])
            {
                NSString *rowString = cellView.textField.stringValue;
                if (rowString != nil)
                {
                    [tableHTML appendFormat:@"<td>%@</td>",rowString];
                }
                else
                {
                    ATLog(@"NSTableCellView's textField is nil. Using an empty string for row: %li column: %li",currentRow,currentColumn);
                    [tableHTML appendFormat:@"<td>%@</td>",@""];
                }
            }
            else
            {
                ATLog(@"Table view isn't using NSTableCellView. Using an empty string for row: %li column: %li",currentRow,currentColumn);
                [tableHTML appendFormat:@"<td>%@</td>",@""];
            }
            
            currentColumn++;
        }
        
        if (currentColumn >= self.tableColumns.count)
        {
            currentRow++;
            currentColumn = 0;
            [tableHTML appendString:@"</tr>"];
            
            if (currentRow < self.numberOfRows)
            {
                [tableHTML appendString:@"<tr>"];
            }
        }
        
        if (currentRow >= self.numberOfRows)
        {
            dipThroughRowsAndColumns = NO;
        }
    }
    
    [tableHTML appendString:@"</table>"];
    [htmlString appendString:tableHTML];
    [htmlString appendString:closingHTML];
    
    return htmlString;
}

-(void)setCssForHtmlRepresentation:(NSString*)cssForHtmlRepresentation
{
    if (cssForHtmlRepresentation == nil) { cssForHtmlRepresentation = self.defaultCssStyle; }
    _cssForHtmlRepresentation = cssForHtmlRepresentation;
}

@end
