//
//  UIWebView+SearchWebView.m
//  ZPMCache
//
//  Created by 刘钊 on 2018/4/29.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import "UIWebView+SearchWebView.h"

@implementation UIWebView (SearchWebView)

- (NSInteger)highlightAllOccurencesOfString:(NSString*)str index:(NSInteger)index
{
    [self getHighlightAllOccurencesOfString:str index:index];
    NSString *result = [self stringByEvaluatingJavaScriptFromString:@"MyApp_SearchResultCount"];
    return [result integerValue];
}

- (void)getHighlightAllOccurencesOfString:(NSString*)str index:(NSInteger)index
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HighlightKeywords" ofType:@"js"];
//    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *jsCode = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self stringByEvaluatingJavaScriptFromString:jsCode];
    
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@', '%ld')",str, (long)index];
    [self stringByEvaluatingJavaScriptFromString:startSearch];
}

- (void)removeAllHighlights
{
    [self stringByEvaluatingJavaScriptFromString:@"MyApp_RemoveAllHighlights()"];
}

@end
