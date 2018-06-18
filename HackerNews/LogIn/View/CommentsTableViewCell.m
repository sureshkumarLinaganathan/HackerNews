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

-(void)setupView:(Comment*)comment{
    [self createCardView];
    self.commentsLabel.text = comment.comment;
    self.dateLabel.text = [NSString stringWithFormat:@"%@.%@", comment.time,comment.submitter];
}

-(void)createCardView{
    self.cardView.layer.masksToBounds = NO;
    self.cardView.layer.cornerRadius = 0;
    self.cardView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.cardView.layer.shadowRadius = 2.0;
    self.cardView.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    self.cardView.layer.shadowOpacity = 1.0;
}

@end

