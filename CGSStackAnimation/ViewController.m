//
//  ViewController.m
//  CGSStackAnimation
//
//  Created by Colin Smith on 11/20/15.
//  Copyright © 2015 Colin Smith. All rights reserved.
//

#import "ViewController.h"
#import "CGSLeaderTableViewCell.h"
#import "CGSLeader.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leaderTableView;
@property (strong, nonatomic) NSArray *leaders;
@property (strong, nonatomic) NSArray *leaders2;
@property (nonatomic) BOOL isUsingLeaders1;
@property (nonatomic) CGFloat currentRowYOffset;
@property (nonatomic) CGFloat currentAnimationTime;
@property (nonatomic) CGFloat lastAnimationTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leaderTableView.delegate = self;
    self.leaderTableView.dataSource = self;
    [self.leaderTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CGSLeaderTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"leaderCell"];
    NSMutableArray *createLeadersArray = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 1; i <=10; i++) {
        CGSLeader *newLeader = [CGSLeader new];
        newLeader.name = @"Rob Boyle";
        newLeader.position = [NSString stringWithFormat:@"%d", i];
        newLeader.points = @"200";
        [createLeadersArray addObject:newLeader];
    }
    self.leaders = [createLeadersArray copy];
    [createLeadersArray removeAllObjects];
    for (int i = 1; i <=10; i++) {
        CGSLeader *newLeader = [CGSLeader new];
        newLeader.name = @"Billy Boyle";
        newLeader.position = [NSString stringWithFormat:@"%d", i];
        newLeader.points = @"24";
        [createLeadersArray addObject:newLeader];
    }
    self.leaders2 = [createLeadersArray copy];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSLeaderTableViewCell *cell = [self.leaderTableView dequeueReusableCellWithIdentifier:@"leaderCell" forIndexPath:indexPath];
    if (self.isUsingLeaders1) {
        [cell setupWithLeader:self.leaders[indexPath.row]];
    } else {
        [cell setupWithLeader:self.leaders2[indexPath.row]];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leaders.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        self.currentRowYOffset = 0;
        self.currentAnimationTime = 0.6;
    } else if (indexPath.row == 9) {
        self.lastAnimationTime = self.currentAnimationTime;
    }
    __block CGRect newFrame = cell.frame;
    newFrame.origin.y = 1000;
    cell.frame = newFrame;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.currentAnimationTime animations:^{
        newFrame = cell.frame;
        newFrame.origin.y = self.currentRowYOffset;
        cell.frame = newFrame;
        weakSelf.currentRowYOffset += cell.frame.size.height;
        weakSelf.currentAnimationTime = (weakSelf.currentAnimationTime + 0.1) * 1.005;
    }];

}

- (IBAction)reloadData:(id)sender {
    self.isUsingLeaders1 = !self.isUsingLeaders1;
    [self.leaderTableView reloadData];
}

- (IBAction)reloudOut:(id)sender {
    for (int i = 9; i >= 0; i--) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CGSLeaderTableViewCell *cell = [self.leaderTableView cellForRowAtIndexPath:indexPath];
        if (i == 0) {
            self.currentAnimationTime = self.lastAnimationTime;
        }
        __block CGRect newFrame = cell.frame;
        CGFloat timedelay = (9 - indexPath.row + 0.06) * 0.08;
        [UIView animateWithDuration:0.5 delay:timedelay options:0 animations:^{
            newFrame = cell.frame;
            newFrame.origin.y = 1000;
            cell.frame = newFrame;
        } completion:nil];
    }
}

@end
