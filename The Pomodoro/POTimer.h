//
//  POTimer.h
//  The Pomodoro
//
//  Created by sombra on 2015-02-16.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POTimer : NSObject

@property (nonatomic,assign) NSInteger minutes;
@property (nonatomic,assign) NSInteger seconds;

+ (POTimer *)sharedInstance;

- (void)startTimer;
- (void)cancelTimer;

@end
