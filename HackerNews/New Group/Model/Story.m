//
//  Story.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "Story.h"
#import "NSDate+Additions.h"

@implementation Story

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self.articleTitle = [dict objectForKey:@"title"];
    self.submitter = [dict objectForKey:@"by"];
    self.dateOfSubmission = [NSDate timeAgoFromTimeIntervalString:[dict objectForKey:@"time"]];
    self.numberOfVotes = [NSString stringWithFormat:@"%@", [dict objectForKey:@"score"]];
    self.totalComments = [NSString stringWithFormat:@"%@", [dict objectForKey:@"descendants"]];
    self.websiteURL = [dict objectForKey:@"url"];
    self.commentsKey = [[NSArray alloc]init];
    self.commentsKey = [dict objectForKey:@"kids"];
    return self;
}


@end

