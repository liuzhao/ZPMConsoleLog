//
//  ViewController.m
//  ZPMConsoleLog
//
//  Created by 刘钊 on 2018/5/1.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import "ViewController.h"
#import "ZPMLog.h"
#import "ZPMConsoleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *fileName = @"ZPMLog2.js"; //[NSString stringWithFormat:@"%@.log",[NSDate date]];
    //获取document目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *logFilePath = [docDir stringByAppendingPathComponent:fileName];

//#ifdef DEBUG
    __weak __typeof(self)weakSelf = self;
    [[ZPMLog shareInstance] setFilePath:logFilePath];
    [[ZPMLog shareInstance] showConsoleWindowWithImagesAndTitle:@{@"icon_1":@"用户中心", @"icon_2":@"退出登录", @"icon_3":@"客服中心"} handleClick:^(NSInteger i) {
        NSLog(@"click=%zd",i);
        if (i == 0) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ZPMConsoleViewController new]];
            [weakSelf presentViewController:nav animated:YES completion:nil];
//            [weakSelf.navigationController pushViewController:[ZPMConsoleViewController new] animated:YES];
        }
    }];
//#endif
    
    NSLog(@"viewDidLoad");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
