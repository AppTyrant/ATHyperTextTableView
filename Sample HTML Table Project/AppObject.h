//
//  AppObject.h
//  Sample HTML Table Project
//
//  Created by ANTHONY CRUZ on 1/7/17.
//  Copyright © 2017 Writes for All Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppObject : NSObject

-(nonnull instancetype)initWithName:(nonnull NSString*)name
                           category:(nonnull NSString*)category
                                sku:(nonnull NSString*)sku
                     websiteAddress:(nonnull NSString*)websiteAddress NS_DESIGNATED_INITIALIZER;

-(nullable instancetype)init NS_UNAVAILABLE;

@property (nonnull,strong,readonly) NSString *name;
@property (nonnull,strong,readonly) NSString *category;
@property (nonnull,strong,readonly) NSString *sku;
@property (nonnull,strong,readonly) NSString *websiteAddress;

@end

@interface AppObject (Common)

+(nonnull AppObject*)visualAttributedString;
+(nonnull AppObject*)fileCabinetPro;
+(nonnull AppObject*)desktopGhostPro;
+(nonnull AppObject*)rawDogXMLViewer;
+(nonnull AppObject*)pdfImageXtractor;
+(nonnull AppObject*)wordCounterPro;

@end
