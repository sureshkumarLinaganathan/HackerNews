//
//  Comment.h
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, strong) NSString *submitter;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *time;

-(Comment*)initWithDictionary:(NSDictionary*)dictionary;

@end
