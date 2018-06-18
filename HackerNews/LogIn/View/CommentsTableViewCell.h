//
//  CommentsTableViewCell.h
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

FOUNDATION_EXPORT  NSString *const commentsTableViewCellReuseIdentifier ;

@interface CommentsTableViewCell : UITableViewCell

-(void)setupView:(Comment*)comment;

@end

