//
//  UITextField+TextFieldEffects.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "UITextField+TextFieldEffects.h"

@implementation UITextField (TextFieldEffects)

-(void)createRoundCornerTextField{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 27.0;
    self.layer.borderWidth = 0.8;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

-(void)addPadding{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}



@end
