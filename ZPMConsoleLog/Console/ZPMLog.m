//
//  ZPMLog.m
//  ZPMCache
//
//  Created by 刘钊 on 2018/4/30.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import "ZPMLog.h"
#import "ZPMConsoleViewController.h"

// 屏幕高度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface ZPMLog()

@end

@implementation ZPMLog

static ZPMLog *zpmLog;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    // 一次函数
    dispatch_once(&onceToken, ^{
        if (zpmLog == nil) {
            zpmLog = [[self alloc] init];
        }
    });
    
    return zpmLog;
}

- (NSString *)getLogFilePath
{
    NSString *fileName = @"ZPMLog.js"; //[NSString stringWithFormat:@"%@.log",[NSDate date]];
    //获取document目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *logFilePath = [docDir stringByAppendingPathComponent:fileName];
    
    return logFilePath;
}

- (void)openNSLogToDocumentFolder
{
    freopen([[self getLogFilePath] cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}

- (void)closeNSLogToDocumentFolder
{
    fclose(stderr);
}

- (void)showMeum
{
    if (!self.suspensionBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor grayColor];
        btn.frame = CGRectMake(SCREEN_WIDTH - 60 - 15, SCREEN_HEIGHT - 60 - 64, 60, 60);
        btn.layer.cornerRadius = btn.frame.size.height/2;
        btn.layer.shadowOffset = CGSizeMake(3, 3);
        btn.layer.shadowColor = [UIColor blackColor].CGColor;
        btn.layer.shadowOpacity = 0.8;
//        btn.layer.masksToBounds = YES;
        btn.layer.shadowRadius = 2;
        [btn setTitle:@"Log" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pushToLogVC) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:btn];
        self.suspensionBtn = btn;
    }
}

- (void)pushToLogVC
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ZPMConsoleViewController new]];
    [[self getCurrentVC] presentViewController:nav animated:YES completion:^{
        
    }];
    self.suspensionBtn.hidden = YES;
}

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


@end
