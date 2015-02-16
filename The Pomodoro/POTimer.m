//
//  POTimer.m
//  The Pomodoro
//
//  Created by sombra on 2015-02-16.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POTimer.h"

@interface POTimer ()

@property (nonatomic,assign) BOOL isOn;

@end

static NSString * const secondTickNotification = @"secondTick";
static NSString * const currentRoundNotification = @"currentRound";
static NSString * const roundCompleteNotification = @"roundComplete";

@implementation POTimer

+ (POTimer *)sharedInstance {
    static POTimer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[POTimer alloc] init];
    });
    return sharedInstance;
}
-(void)registerForNotification{
    
}
-(void)secondTick {
    [self performSelector:@selector(decreaseSecond) withObject:nil afterDelay:1.0];
}

-(void)startTimer {
    self.isOn = YES;
}

-(void)cancelTimer {
    self.isOn = NO;
}

-(void)endTimer {
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:roundCompleteNotification object:nil];
}

-(void)decreaseSecond {
    while (self.seconds > 0 || self.minutes > 0) {
        if (self.seconds > 0) {
            self.seconds--;
            [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
        } else if (self.seconds == 0 && self.minutes > 0) {
            self.seconds = 59;
            self.minutes--;
            [[NSNotificationCenter defaultCenter] postNotificationName:secondTickNotification object:nil];
        } else {
            [self endTimer];
        }
    }
}

- (void)isActive {
    if (self.isOn) {
        [self decreaseSecond];
        [self performSelector:@selector(isActive) withObject:nil afterDelay:1.0];
    }
}

@end
