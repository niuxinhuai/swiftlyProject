//
//  NSString+commend.m
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/21.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

#import "NSString+commend.h"

@implementation NSString (commend)

+ (NSString*)encodeString:(NSString*)unencodedString {
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)unencodedString,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8));
    
    return encodedString;
}

+ (WKUserScript *)userScript{
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    var imgScr = '';\
    for(var i=0;i<objs.length;i++){\
    imgScr = imgScr + objs[i].src + '+';\
    };\
    return imgScr;\
    };function registerImageClickAction(){\
    var imgs=document.getElementsByTagName('img');\
    var length=imgs.length;\
    for(var i=0;i<length;i++){\
    img=imgs[i];\
    img.onclick=function(){\
    window.location.href='image-preview:'+this.src}\
    }\
    }";
    
    WKUserScript * script = [[WKUserScript alloc]initWithSource:jsGetImages injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    return script;
    
    
}

@end
