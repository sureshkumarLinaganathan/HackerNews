//
//  Story.h
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject

@property (strong, nonatomic) NSString *articleTitle;
@property (strong, nonatomic) NSString *submitter;
@property (strong, nonatomic) NSString *dateOfSubmission;
@property (strong, nonatomic) NSString *numberOfVotes;
@property (strong, nonatomic) NSString *totalComments;
@property (strong, nonatomic) NSString *websiteURL;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end



