//
//  CGSLeaderTableViewCell.m
//  CGSStackAnimation
//
//  Created by Colin Smith on 11/20/15.
//  Copyright © 2015 Colin Smith. All rights reserved.
//

#import "CGSLeaderTableViewCell.h"
#import "CGSLeader.h"

@interface CGSLeaderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *leaderPositionLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaderPointLabel;

@end

@implementation CGSLeaderTableViewCell

- (void)setupWithLeader:(CGSLeader *)leader {
    self.leaderNameLabel.text = leader.name;
    self.leaderPointLabel.text = leader.points;
    self.leaderPositionLabel.text = leader.position;
}

@end
