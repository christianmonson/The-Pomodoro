//
//  POAppearanceController.m
//  The Pomodoro
//
//  Created by sombra on 2015-02-17.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POAppearanceController.h"

@implementation POAppearanceController

+ (void)initilizeAppearanceDefaults {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Courier" size:30], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    [[UITabBar appearance] setBarTintColor:[UIColor redColor]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
}

@end
