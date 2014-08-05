//
//  EXPMatchers+error.m
//  Kyle Fuller
//
//  Created by Kyle Fuller on 05/07/2014.
//  Copyright (c) 2014 Kyle Fuller. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "EXPMatchers+error.h"

EXPMatcherImplementationBegin(error, ()) {
    RACSignal *signal;

    __block BOOL didError = NO;
    __block BOOL didComplete = NO;

    if ([actual isKindOfClass:[RACSignal class]]) {
        signal = actual;

        [signal subscribeError:^(NSError *error) {
            didError = YES;
        } completed:^{
            didComplete = YES;
        }];
    }

    match(^ BOOL {
        return signal && didError;
    });

    failureMessageForTo(^ NSString * {
        NSString *message;

        if (didComplete) {
            message = [NSString stringWithFormat:@"Signal %@ completed instead of erroring.", signal];
        } else if (signal == nil) {
            message = @"Signal is nil.";
        } else {
            message = @"Signal did not produce an error.";
        }

        return message;
    });
}

EXPMatcherImplementationEnd
