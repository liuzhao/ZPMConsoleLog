//
//  UIWebView+SearchWebView.h
//  ZPMCache
//
//  Created by 刘钊 on 2018/4/29.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (SearchWebView)

- (void)getHighlightAllOccurencesOfString:(NSString*)str index:(NSInteger)index;

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str index:(NSInteger)index;

- (void)removeAllHighlights;

@end
