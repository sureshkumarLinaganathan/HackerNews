//
//  Comment.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "Comment.h"
#import "NSDate+Additions.h"

@implementation Comment

#pragma mark - Init comments object

-(Comment*)initWithDictionary:(NSDictionary *)dictionary{
    
    self.submitter = dictionary[@"by"];
    self.time = [NSDate timeAgoFromTimeIntervalString: dictionary[@"time"]];
    self.comment = dictionary[@"text"];
    return self;
}

@end
