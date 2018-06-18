//
//  Webservice.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "Webservice.h"
#import "Story.h"

NSString *const api = @"https://hacker-news.firebaseio.com/v0/item/";
NSString *const keyValue = @"print=pretty";
NSString *const topStories = @"https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty";

@implementation Webservice

#pragma mark -Fetch top stories keys

-(void)getTopStories:(void (^)(BOOL, NSMutableArray *,NSString*))completionBlock{
    
    NSMutableArray *storyArray = [[NSMutableArray alloc]init];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSString *stringUrl = [NSString stringWithFormat:@"%@",topStories];
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *parseError;
            if(error == nil){
               NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                if(json) {
                    [storyArray addObjectsFromArray:json];
                    completionBlock(YES,storyArray,@"");
                }
            }else{
                completionBlock(NO,storyArray,error.localizedDescription);
            }
        });
    }];
    [dataTask resume];
            
}

#pragma mark -Fetch top stories

-(void)getStoriesForKey:(NSString*)key withCompletionBlock:(void (^)(BOOL,Story*,NSString*))completionBlock{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@.json?%@",api,key,keyValue];
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *parseError;
            if(error == nil){
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                if(json) {
                    Story *story = [[Story alloc]initWithDictionary:json];
                    completionBlock(YES,story,@"");
                }
            }else{
                completionBlock(NO,nil,error.localizedDescription);
            }
        });
    }];
    [dataTask resume];
}

#pragma mark -Fetch comments

-(void)getCommentsForKey:(NSString *)key withCompletionBlock:(void (^)(BOOL, Comment *, NSString *))completionBlock{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@.json?%@",api,key,keyValue];
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *parseError;
            if(error == nil){
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
                if(json) {
                    Comment *comment = [[Comment alloc]initWithDictionary:json];
                    completionBlock(YES,comment,@"");
                }
            }else{
                completionBlock(NO,nil,error.localizedDescription);
            }
        });
    }];
    [dataTask resume];
}

@end
