//
//  AppObject.m
//  Sample HTML Table Project
//
//  Created by ANTHONY CRUZ on 1/7/17.
//  Copyright © 2017 Writes for All Inc. All rights reserved.
//

#import "AppObject.h"

@implementation AppObject

-(instancetype)initWithName:(NSString*)name
                   category:(NSString*)category
                        sku:(NSString*)sku
             websiteAddress:(NSString*)websiteAddress
{
    self = [super init];
    if (self)
    {
        _name = name;
        _category = category;
        _sku = sku;
        _websiteAddress = websiteAddress;
    }
    return self;
}

@end

@implementation AppObject (Common)

+(AppObject*)visualAttributedString
{
    return [[self alloc]initWithName:@"Visual Attributed String"
                            category:@"Developer Tools"
                                 sku:@"00002024234234"
                      websiteAddress:@"http://visualattributedstring.blogspot.com"];
}

+(AppObject*)fileCabinetPro
{
    return [[self alloc]initWithName:@"File Cabinet Pro"
                            category:@"Utilities"
                                 sku:@"00002024234234"
                      websiteAddress:@"https://apptyrant.com/file-cabinet-pro-help/"];
}

+(AppObject*)desktopGhostPro
{
    return [[self alloc]initWithName:@"Desktop Ghost Pro"
                            category:@"Utilities"
                                 sku:@"00002024234234"
                      websiteAddress:@"https://apptyrant.com/desktop-ghost-pro/"];
}

+(AppObject*)rawDogXMLViewer
{
    return [[self alloc]initWithName:@"Raw Dog XML Viewer"
                            category:@"Developer Tools"
                                 sku:@"00002024234234"
                      websiteAddress:@"https://apptyrant.com/raw-dog-xml-viewer/"];
}

+(AppObject*)pdfImageXtractor
{
    return [[self alloc]initWithName:@"PDF Image Xtractor"
                            category:@"Utilities"
                                 sku:@"00002024234234"
                      websiteAddress:@"https://apptyrant.com/pdf-image-xtractor/"];
}

+(AppObject*)wordCounterPro
{
    return [[self alloc]initWithName:@"Word Counter Pro"
                            category:@"Productivity"
                                 sku:@"00002024234234"
                      websiteAddress:@"https://apptyrant.com/word-counter-pro/"];
}


@end
