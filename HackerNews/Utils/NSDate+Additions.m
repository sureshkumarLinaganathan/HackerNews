//
//  NSDate+Additions.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#define minInSec (60)
#define hourInSec (minInSec * minInSec)
#define dayInSec (24 * hourInSec)
#define monthInSec (30 * dayInSec)
#define yearInSec (12 * monthInSec)

#import "NSDate+Additions.h"

@implementation NSDate (Additions)

+ (NSString *)timeAgoFromTimeIntervalString:(NSString *)timeIntervalString {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeIntervalString doubleValue]];
    NSString *returnString;
    NSTimeInterval interval = -[date timeIntervalSinceNow];
    
    if (interval < minInSec) {
        returnString = @"just now";
    }
    else if (interval < hourInSec) {
        returnString = [NSString stringWithFormat:@"%ld min ago", (long)interval / minInSec];
    }
    else if (interval < 2 * hourInSec) {
        returnString = [NSString stringWithFormat:@"%ld hour ago", (long)interval / hourInSec];
    }
    else if (interval < dayInSec) {
        returnString = [NSString stringWithFormat:@"%ld hours ago", (long)interval / hourInSec];
    }
    else if (interval < 2 * dayInSec) {
        returnString = [NSString stringWithFormat:@"%ld day ago", (long)interval / dayInSec];
    }
    else if (interval < monthInSec) {
        returnString = [NSString stringWithFormat:@"%ld days ago", (long)interval / dayInSec];
    }
    else if (interval < 2 * monthInSec) {
        returnString = [NSString stringWithFormat:@"%ld month ago", (long)interval / monthInSec];
    }
    else if (interval < yearInSec) {
        returnString = [NSString stringWithFormat:@"%ld months ago", (long)interval / monthInSec];
    }
    else if (interval < 2 * yearInSec) {
        returnString = [NSString stringWithFormat:@"%ld year ago", (long)interval / yearInSec];
    }
    else {
        returnString = [NSString stringWithFormat:@"%ld years ago", (long)interval / yearInSec];
    }
    
    return returnString;
}


@end

