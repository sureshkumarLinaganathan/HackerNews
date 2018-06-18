//
//  HomeTableViewCell.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *voteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@end

@implementation HomeTableViewCell

- (void)setStory:(Story *)story {
    [self.articleTitleLabel setText:story.articleTitle];
    [self.websiteLabel setText:story.websiteURL];
    [self.timeLabel setText:[NSString stringWithFormat:@"%@.%@",story.dateOfSubmission,story.submitter]];
    [self.commentCountLabel setText:story.totalComments];
    [self.voteCountLabel setText:story.numberOfVotes];
}

@end

