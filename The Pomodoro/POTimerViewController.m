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
    self.timerLabel.text = [NSString stringWithFormat:@"%li:%02li", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
}

- (IBAction)timerButtonPressed:(id)sender {
    [[POTimer sharedInstance] startTimer];
    self.timerButton.enabled = NO;
}

- (void)newRound {
    [self updateLabel];
    self.timerButton.enabled = YES;
}

#pragma NSNotificationCenter

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLabel) name:secondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:currentRoundNotification object:nil];
}

- (void)deRegisterForNotification {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)dealloc {
    [self deRegisterForNotification];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [self registerForNotifications];
    }
    return self;
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
