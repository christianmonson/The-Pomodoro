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
@property (weak, nonatomic) IBOutlet UIImageView *roundImage;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@end

static NSString * const secondTickNotification = @"secondTick";
static NSString * const currentRoundNotification = @"currentRound";
static NSString * const roundCompleteNotification = @"roundComplete";
static NSString * const relaxColorNotification = @"relax";
static NSString * const workColorNotification = @"work";

@implementation POTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pauseButton.hidden = TRUE;
    self.pauseButton.tintColor = [UIColor whiteColor];
    self.timerButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)updateLabel {
    self.timerLabel.text = [NSString stringWithFormat:@"%li:%02li", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
}

- (IBAction)timerButtonPressed:(id)sender {
    [[POTimer sharedInstance] startTimer];
//    self.timerButton.enabled = NO;
    self.timerButton.hidden = TRUE;
    self.pauseButton.hidden = FALSE;
}

- (IBAction)pause:(id)sender {
    [[POTimer sharedInstance] cancelTimer];
    self.pauseButton.hidden = TRUE;
    self.timerButton.hidden = FALSE;
}

- (void)newRound {
    [self updateLabel];
    self.timerButton.enabled = YES;
    self.pauseButton.hidden = TRUE;
    self.timerButton.hidden = FALSE;
}

- (void)relax {
    self.view.backgroundColor = [UIColor colorWithRed:0.2039 green:0.5961 blue:0.8588 alpha:1.0];
    self.timerLabel.textColor = [UIColor whiteColor];
    self.timerButton.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.2039 green:0.5961 blue:0.8588 alpha:1.0];
    self.roundImage.image = [UIImage imageNamed:@"Joystick-white"];
    self.roundImage.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)work {
    self.view.backgroundColor = [UIColor redColor];
    self.timerLabel.textColor = [UIColor whiteColor];
    self.timerButton.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    self.roundImage.image = [UIImage imageNamed:@"Worker-white"];
    self.roundImage.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma NSNotificationCenter

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateLabel) name:secondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:currentRoundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relax) name:relaxColorNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(work) name:workColorNotification object:nil];
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
