//
//  ZPMLog.h
//  ZPMCache
//
//  Created by 刘钊 on 2018/4/30.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZPMLog : NSObject

// 悬浮按钮
@property (nonatomic, strong) UIButton *suspensionBtn;

+ (instancetype)shareInstance;

- (NSString *)getLogFilePath;

- (void)openNSLogToDocumentFolder;

- (void)closeNSLogToDocumentFolder;

- (void)showMeum;

@end
