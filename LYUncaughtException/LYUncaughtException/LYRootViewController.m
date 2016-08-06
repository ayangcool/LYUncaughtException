//
//  LYRootViewController.m
//  LYUncaughtException
//
//  Created by leo on 16/8/6.
//  Copyright © 2016年 leo. All rights reserved.
//

#import "LYRootViewController.h"
#import "LYUncaughtExceptionHandler.h"
#import "LYDetailViewController.h"

@interface LYRootViewController () <UIAlertViewDelegate>

@property (nonatomic, assign) BOOL exit;

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
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pushBtn.frame = CGRectMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 40, 100, 40);
    pushBtn.backgroundColor = [UIColor redColor];
    [pushBtn addTarget:self action:@selector(handlePushButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
    // 打开异常捕获
//    InstallUncaughtExceptionHandler();
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);// 1.开始捕获异常
}

- (void)handleButtonAction:(UIButton *)sender {
    NSString *str = @"abc";
    NSString *str1 = [str substringFromIndex:11];// 到这里就会出现异常
}

- (void)handlePushButtonAction:(UIButton *)sender {
    LYDetailViewController *detailVC = [[LYDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

// 2.在方法里做异常的捕获和处理
void UncaughtExceptionHandler(NSException *exception) {
    //不退出是因为waitUntilDone设置为YES
    [[[LYRootViewController alloc] init] performSelectorOnMainThread:@selector(handleException:) withObject:exception waitUntilDone:YES];
}
- (void)handleException:(NSException *)exception {
    // 获取异常崩溃信息
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
    NSLog(@"%@", content);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"程序发生错误，是否退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!self.exit) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.exit = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
