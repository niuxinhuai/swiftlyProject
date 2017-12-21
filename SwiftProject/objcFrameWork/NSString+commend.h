//
//  NSString+commend.h
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/21.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WebKit;
@interface NSString (commend)

+ (NSString*)encodeString:(NSString*)unencodedString;

+ (WKUserScript *)userScript;

@end
