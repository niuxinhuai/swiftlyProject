//
//  WeakScriptMessageDelegate.h
//  SwiftProject
//
//  Created by 牛新怀 on 2017/12/21.
//  Copyright © 2017年 牛新怀. All rights reserved.
//

/*
 [config.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc]initWithDelegate:self] name:@"webViewApp"];
 避免WKWebView内存泄漏
 */

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>
@property (nonatomic,weak)id<WKScriptMessageHandler> scriptDelegate;
/*
 *初始化并设置代理
 */
-(instancetype)initWithDelegate:(id<WKScriptMessageHandler>) scriptDelegate;
@end
