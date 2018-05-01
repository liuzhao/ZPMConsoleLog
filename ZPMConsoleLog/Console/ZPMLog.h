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


/**
 悬浮按钮
 */
@property (nonatomic, strong) UIButton *suspensionBtn;

/**
 文件路径，可自己设置日志文件存放路径
 */
@property (nonatomic, copy) NSString *filePath;

+ (instancetype)shareInstance;

/**
 显示控制台悬浮窗
 */
- (void)showConsoleWindow;

/**
 获取日志文件路径

 @return return 日志路径
 */
- (NSString *)getLogFilePath;

/**
 打开记录到日志文件，打开后，xcode控制台将不会显示出信息
 */
- (void)openNSLogToDocumentFolder;

/**
 关闭记录到日志文件，关闭后，xcode控制台将会显示出信息
 */
- (void)closeNSLogToDocumentFolder;

@end
