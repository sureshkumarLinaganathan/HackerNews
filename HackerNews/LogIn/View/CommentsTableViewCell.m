//
//  CommentsTableViewCell.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "CommentsTableViewCell.h"

NSString *const commentsTableViewCellReuseIdentifier = @"commentsTableViewCellReuseIdentifier";
@interface CommentsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation CommentsTableViewCell

-(void)setupView{
    
}

@end

