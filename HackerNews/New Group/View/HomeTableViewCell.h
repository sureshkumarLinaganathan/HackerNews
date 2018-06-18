//
//  HomeTableViewCell.h
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@interface HomeTableViewCell : UITableViewCell

- (void)setStory:(Story *)story;

@end
