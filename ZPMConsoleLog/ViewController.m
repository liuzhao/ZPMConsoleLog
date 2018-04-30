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
    
    [[ZPMLog shareInstance] openNSLogToDocumentFolder];
    [[ZPMLog shareInstance] showMeum];
    
    NSLog(@"viewDidLoad");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
