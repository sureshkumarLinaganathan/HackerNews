//
//  LogInViewController.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "LogInViewController.h"
#import "HomeViewController.h"
#import "DGActivityIndicatorView.h"

@import Firebase;
@import GoogleSignIn;

@interface LogInViewController ()<GIDSignInUIDelegate,GIDSignInDelegate>
{
    DGActivityIndicatorView *activityIndicatorView;
    UIView *view;
}
@property (weak, nonatomic) IBOutlet UIButton *signInButton;


@end

@implementation LogInViewController

#pragma mark -View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].uiDelegate = self;
    [self addloadingIndicator];
}

#pragma mark - Google sign in

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    if (error == nil) {
        GIDAuthentication *authentication = user.authentication;
        FIRAuthCredential *credebtials = [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken accessToken:authentication.accessToken];
        [[FIRAuth auth] signInAndRetrieveDataWithCredential:credebtials completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            if (error) {
                return;
            }
            // User successfully signed in. Get user data from the FIRUser object
            if (authResult == nil) { return; }
            [activityIndicatorView stopAnimating];
            [view setHidden:YES];
            [self.view setUserInteractionEnabled:YES];
            [self performSegueWithIdentifier:homeViewControllerSegue sender:self];
        }];
    } else {
        [activityIndicatorView stopAnimating];
        [view setHidden:YES];
        [self.view setUserInteractionEnabled:YES];
        NSLog(@"error");
    }
    
}

#pragma  mark -IBActions

- (IBAction)signInButtonTapped:(id)sender {
    [view setHidden:NO];
    [view bringSubviewToFront:activityIndicatorView];
    [self.view setUserInteractionEnabled:NO];
    [activityIndicatorView startAnimating];
    [[GIDSignIn sharedInstance] signIn];
}

-(void)addloadingIndicator{
    view = [[UIView alloc] initWithFrame:self.view.frame];
    [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [view setUserInteractionEnabled:NO];
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor orangeColor] size:80.0f];
    activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    activityIndicatorView.center = view.center;
    [view addSubview:activityIndicatorView];
    [self.view addSubview:view];
    [view setHidden:YES];
    
}


@end
