//
//  Webservice.h
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"
#import "Comment.h"

@interface Webservice : NSObject

-(void)getTopStories:(void (^)(BOOL success,NSMutableArray *objects,NSString *errorMsg))completionBlock;
-(void)getStoriesForKey:(NSString*)key withCompletionBlock:(void (^)(BOOL success,Story *story,NSString* errorMsg))completionBlock;
-(void)getCommentsForKey:(NSString*)key withCompletionBlock:(void (^)(BOOL success,Comment *comment,NSString* errorMsg))completionBlock;
    


@end
