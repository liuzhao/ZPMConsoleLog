//
//  ZPMSuspensionWindow.h
//  ZPMConsoleLog
//
//  Created by Liu Zhao on 2018/5/2.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallTheService)(void);

@interface ZPMDebugOverlay : UIView

@property (nonatomic,copy) CallTheService callService;

@property (nonatomic,copy) void(^clickBolcks)(NSInteger i);

//  warning: frame的长宽必须相等
- (instancetype)initWithFrame:(CGRect)frame mainImageName:(NSString*)name bgcolor:(UIColor *)bgcolor;

// 长按雷达辐射效果
- (instancetype)initWithFrame:(CGRect)frame mainImageName:(NSString*)name bgcolor:(UIColor *)bgcolor animationColor:animationColor;

// 带imagesAndTitle
- (instancetype)initWithFrame:(CGRect)frame mainImageName:(NSString*)name imagesAndTitle:(NSDictionary*)imagesAndTitle bgcolor:(UIColor *)bgcolor animationColor:animationColor;

// 显示（默认）
- (void)showWindow;

// 隐藏
- (void)dissmissWindow;

@end
