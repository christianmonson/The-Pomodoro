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

@end

static NSString * const secondTickNotification = @"secondTick";
static NSString * const currentRoundNotification = @"currentRound";
static NSString * const roundCompleteNotification = @"roundComplete";

@implementation PORoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Rounds";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
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
}

#pragma NSNotificationCenter

- (void)registerForNotification {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(roundComplete) name:roundCompleteNotification object:nil];
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
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)dealloc {
    [self deRegisterForNotification];
}

#pragma UITableViewDataSource

- (NSArray *)rounds {
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self rounds][indexPath.row]];
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
