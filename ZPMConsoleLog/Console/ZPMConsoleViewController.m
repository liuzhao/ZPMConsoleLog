//
//  ZPMLogViewController.m
//  ZPMCache
//
//  Created by 刘钊 on 2018/4/29.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import "ZPMConsoleViewController.h"
#import "UIWebView+SearchWebView.h"
#import "ZPMLog.h"

#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@interface ZPMConsoleViewController ()<UIWebViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) NSInteger keywordCount;
@property (nonatomic, assign) NSInteger clickTimes;
@property (nonatomic, strong) UISearchBar *searchbar;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIBarButtonItem *nextItem;
@property (nonatomic, strong) UIBarButtonItem *previousItem;
@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation ZPMConsoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"Console";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clearLog)];
    
    [self setupMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Setup

- (void)setupMainView
{
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [self.view addSubview:view];
    
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    searchbar.delegate = self;
    [view addSubview:searchbar];
    self.searchbar = searchbar;
    
    NSString *logFilePath = [[ZPMLog shareInstance] getLogFilePath];
    
    NSURL *url = [NSURL fileURLWithPath:logFilePath];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - statusHeight - 44 - view.frame.size.height - 44)];
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.center = self.view.center;
    [self.view addSubview:self.activityView];
    
    CGFloat bottom_space = (IS_IPHONE_X ? 34.0 : 0.0);
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - statusHeight - 44 - 44 - bottom_space, self.view.frame.size.width, 44 + bottom_space)];
    [self.view addSubview:toolbar];
    
    self.nextItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"next"]
                                                     style:UIBarButtonItemStylePlain
                                                    target:self
                                                    action:@selector(showNextKeyword)];
    
    self.previousItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"previous"]
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(showPreviousKeyword)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:nil action:nil];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = @"0";
    UIBarButtonItem *numberItem = [[UIBarButtonItem alloc] initWithCustomView:numberLabel];
    self.numberLabel = numberLabel;
    
    [toolbar setItems:[NSArray arrayWithObjects:spaceItem, self.previousItem, spaceItem, numberItem, spaceItem, self.nextItem, spaceItem, nil]];
    
    self.nextItem.enabled = NO;
    self.previousItem.enabled = NO;
    
}

#pragma mark- Action

- (void)dismiss
{
    [ZPMLog shareInstance].suspensionBtn.hidden = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearLog
{
    NSString *logFilePath = [[ZPMLog shareInstance] getLogFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:logFilePath error:nil];
    
    [[ZPMLog shareInstance] openNSLogToDocumentFolder];
    
    [self webViewReload];
}

- (void)showNextKeyword
{
    if (self.clickTimes >= self.keywordCount) {
        _clickTimes = 0;
    }
    self.clickTimes++;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)self.clickTimes];
    
    [self.webView getHighlightAllOccurencesOfString:self.searchbar.text index:self.clickTimes];
}

- (void)showPreviousKeyword
{
    if (self.clickTimes == 1) {
        _clickTimes = self.keywordCount + 1;
    }
    self.clickTimes--;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)self.clickTimes];
    
    [self.webView getHighlightAllOccurencesOfString:self.searchbar.text index:self.clickTimes];
}

- (void)webViewReload
{
    NSURL *url = [NSURL fileURLWithPath:[[ZPMLog shareInstance] getLogFilePath]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark- WebView

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityView stopAnimating];
}

#pragma mark- SearchBar

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.clickTimes = 1;
    self.keywordCount = [self.webView highlightAllOccurencesOfString:searchBar.text index:self.clickTimes];
    if (self.keywordCount > 0) {
        self.nextItem.enabled = YES;
        self.previousItem.enabled = YES;
    }
    else {
        self.nextItem.enabled = NO;
        self.previousItem.enabled = NO;
    }
    self.navigationItem.title = [NSString stringWithFormat:@"TotalCount：%ld",(long)self.keywordCount];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)self.clickTimes];
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.isBeingPresented) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismiss)];
    }
    else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
