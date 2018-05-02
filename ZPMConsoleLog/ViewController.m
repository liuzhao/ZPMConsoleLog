//
//  ViewController.m
//  ZPMConsoleLog
//
//  Created by 刘钊 on 2018/5/1.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import "ViewController.h"
#import "ZPMLog.h"

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
    [[ZPMLog shareInstance] setFilePath:logFilePath];
    [[ZPMLog shareInstance] showConsoleWindow];
//#endif

    
    NSLog(@"viewDidLoad");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
