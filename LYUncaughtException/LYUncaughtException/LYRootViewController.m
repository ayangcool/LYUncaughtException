//
//  LYRootViewController.m
//  LYUncaughtException
//
//  Created by leo on 16/8/6.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "LYRootViewController.h"
#import "LYUncaughtExceptionHandler.h"

@interface LYRootViewController ()

@end

@implementation LYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = self.view.center;
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // 打开异常捕获
    InstallUncaughtExceptionHandler();
    
//    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);// 1.开始捕获异常
}

// 2.在方法里做异常的捕获和处理
//void UncaughtExceptionHandler(NSException *exception) {
//    // 获取异常崩溃信息
//    NSArray *callStack = [exception callStackSymbols];
//    NSString *reason = [exception reason];
//    NSString *name = [exception name];
//    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
//    NSLog(@"%@", content);
//}

- (void)handleButtonAction:(UIButton *)sender {
    NSString *str = @"abc";
    NSString *str1 = [str substringFromIndex:11];// 到这里就会出现异常
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
