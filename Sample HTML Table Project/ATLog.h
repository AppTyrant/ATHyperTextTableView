//
//  ATLog.h
//  Sample HTML Table Project
//
//  Created by ANTHONY CRUZ on 1/7/17.
//  Copyright © 2017 Writes for All Inc. All rights reserved.
//

#ifndef ATLog_h
#define ATLog_h

#if DEBUG
#define ATLog( s, ... ) NSLog( @"<%s : (%d)> %@",__PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define ATLog(s,...)
#endif

#endif /* ATLog_h */
