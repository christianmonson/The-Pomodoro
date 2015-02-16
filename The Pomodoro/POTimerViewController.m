//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by sombra on 2015-02-16.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "POTimerViewController.h"
#import "POTimer.h"

@interface POTimerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *timerButton;

@end

static NSString * const secondTickNotification = @"secondTick";
static NSString * const currentRoundNotification = @"currentRound";
static NSString * const roundCompleteNotification = @"roundComplete";

@implementation POTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLabel {
    self.timerLabel.text = [NSString stringWithFormat:@"%ld:%02ld", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLabel) name:secondTickNotification object:nil];
}

- (POTimerViewController *) init {
    self = [super init];
    [self registerForNotifications];
    return self;
}

- (IBAction)timerButtonPressed:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
