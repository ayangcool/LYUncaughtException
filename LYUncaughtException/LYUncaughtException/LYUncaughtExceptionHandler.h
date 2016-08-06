//
//  LYUncaughtExceptionHandler.h
//  LYUncaughtException
//
//  Created by leo on 16/8/6.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <Foundation/Foundation.h>

void HandleException(NSException *exception);
void SignalHandler(int signal);
void InstallUncaughtExceptionHandler(void);

@interface LYUncaughtExceptionHandler : NSObject {
    BOOL dismissed;
}

@end
