//
//  POAppearanceController.m
//  The Pomodoro
//
//  Created by sombra on 2015-02-17.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POAppearanceController.h"
#import "POTimerViewController.h"

@implementation POAppearanceController

+ (void)initilizeAppearanceDefaults {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor redColor]];
    
    [[UIButton appearanceWhenContainedIn:[POTimerViewController class], nil] setTintColor:[UIColor colorWithRed:0.2039 green:0.5961 blue:0.8588 alpha:1.0]];
}

@end
