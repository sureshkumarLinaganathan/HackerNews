//
//  UIButton+ButtonEffects.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "UIButton+ButtonEffects.h"

@implementation UIButton (ButtonEffects)

-(void)createRoundCornerButton{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 27;
    self.layer.borderWidth = 0.8;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

@end
