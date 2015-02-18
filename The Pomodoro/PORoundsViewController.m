//
//  PORoundsViewController.m
//  The Pomodoro
//
//  Created by sombra on 2015-02-16.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "PORoundsViewController.h"
#import "POTimer.h"

@interface PORoundsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSInteger currentRound;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *cell;

@end

static NSString * const cellIdentifier = @"cell";
static NSString * const secondTickNotification = @"secondTick";
static NSString * const currentRoundNotification = @"currentRound";
static NSString * const roundCompleteNotification = @"roundComplete";
static NSString * const relaxColorNotification = @"relax";
static NSString * const workColorNotification = @"work";

@implementation PORoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Rounds";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 57;
}

- (void)roundSelected:(NSInteger)round {
    [POTimer sharedInstance].minutes = [[self rounds][round] integerValue];
    [POTimer sharedInstance].seconds = 0;
    [[NSNotificationCenter defaultCenter] postNotificationName:currentRoundNotification object:nil];
}

- (void)roundComplete {
    if (self.currentRound != [[self rounds] indexOfObject:[[self rounds] lastObject]]){
        self.currentRound++;
        [self roundSelected:self.currentRound];
    }
    
    if (self.currentRound % 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:relaxColorNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:workColorNotification object:nil];
    }
}

- (void)cellSubtitle {
    self.cell.detailTextLabel.text = [NSString stringWithFormat:@"%li:%02li", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
}

#pragma NSNotificationCenter

- (void)registerForNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roundComplete) name:roundCompleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellSubtitle) name:secondTickNotification object:nil];
}

- (instancetype)init {
    self = [super init];
    if(self)
    {
        [self registerForNotification];
    }
    return self;
}

- (void)deRegisterForNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc {
    [self deRegisterForNotification];
}

#pragma UITableViewDataSource

- (NSArray *)rounds {
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self rounds][indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:@"Courier" size:28.4];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Courier" size:12];
    
    if (indexPath.row % 2) {
        cell.textLabel.textColor = [UIColor colorWithRed:0.2039 green:0.5961 blue:0.8588 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.2039 green:0.5961 blue:0.8588 alpha:1.0];
        cell.imageView.image = [UIImage imageNamed:@"Joystick"];
    }
    else {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.imageView.image = [UIImage imageNamed:@"Worker"];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self rounds].count;
}

#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentRound = indexPath.row;
    [self roundSelected:self.currentRound];
    [[POTimer sharedInstance] cancelTimer];
    
    if (indexPath.row % 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:relaxColorNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:workColorNotification object:nil];
    }
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%li:%02li", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
    self.cell = cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.detailTextLabel.text = @"";
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
