//
//  POTimer.m
//  The Pomodoro
//
//  Created by sombra on 2015-02-16.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POTimer.h"

static NSString * const secondTickNotification = @"secondTick";
static NSString * const currentRoundNotification = @"currentRound";
static NSString * const roundCompleteNotification = @"roundComplete";

@interface POTimer ()

@property (nonatomic,assign) BOOL isOn;

@end



@implementation POTimer

+ (POTimer *)sharedInstance {
    static POTimer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[POTimer alloc] init];
    });
    return sharedInstance;
}

- (void)startTimer {
    self.isOn = YES;
    [self isActive];
}

- (void)cancelTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(decreaseSecond) object:nil];
}

- (void)endTimer {
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:roundCompleteNotification object:nil];
    
    UILocalNotification *localNotification = [UILocalNotification new];
    localNotification.alertBody = @"Time's Up";
    localNotification.soundName = @"bell_three.mp3";
    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)decreaseSecond {

    if (self.seconds > -1){
        self.seconds --;
    }
    
    if (self.minutes > 0 || (self.minutes == 0 && self.seconds > -1)) {
        if (self.seconds == -1) {
            self.seconds = 59;
            self.minutes--;
        }
        
        [[NSNotificationCenter defaultCenter]postNotificationName:secondTickNotification object:nil];
    } else {
        if (self.seconds == -1){
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
