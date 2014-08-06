//
//  EXPMatchers+complete.m
//  Kyle Fuller
//
//  Created by Kyle Fuller on 05/07/2014.
//  Copyright (c) 2014 Kyle Fuller. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "EXPMatchers+complete.h"

EXPMatcherImplementationBegin(complete, ()) {
    RACSignal *signal;
    __block BOOL isComplete = NO;
    __block NSError *signalError;

    if ([actual respondsToSelector:@selector(subscribeError:completed:)]) {
        signal = actual;

        [signal subscribeError:^(NSError *error) {
            signalError = error;
        } completed:^{
            isComplete = YES;
        }];
    }

    match(^ BOOL {
        return signal && isComplete == YES;
    });

    failureMessageForTo(^ NSString * {
        NSString *message;

        if (signalError) {
            message = [NSString stringWithFormat:@"Signal %@ did not complete. (%@).", signal, signalError];
        } else if (signal == nil) {
            message = @"Signal is nil.";
        } else {
            message = @"Signal did not complete.";
        }

        return message;
    });
}

EXPMatcherImplementationEnd

EXPMatcherImplementationBegin(completeSending, (NSArray *values)) {
    RACSignal *signal;
    __block BOOL isComplete = NO;
    __block NSMutableArray *results = [NSMutableArray array];
    __block NSError *signalError;

    if ([actual respondsToSelector:@selector(subscribeError:completed:)]) {
        signal = actual;

        [signal subscribeNext:^(id value) {
            if (value) {
                [results addObject:value];
            } else {
                [results addObject:[NSNull null]];
            }
        } error:^(NSError *error) {
            signalError = error;
        } completed:^{
            isComplete = YES;
        }];
    }

    match(^ BOOL {
        return signal && isComplete == YES && [results isEqualToArray:values];
    });

    failureMessageForTo(^ NSString * {
        NSString *message;

        if (signalError) {
            message = [NSString stringWithFormat:@"Signal %@ did not complete. (%@).", signal, signalError];
        } else if (signal == nil) {
            message = @"Signal is nil.";
        } else if (isComplete) {
            message = [[NSString stringWithFormat:@"Signal sent: %@, expected: %@", results, values] stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        } else {
            message = @"Signal did not complete.";
        }

        return message;
    });
}

EXPMatcherImplementationEnd
