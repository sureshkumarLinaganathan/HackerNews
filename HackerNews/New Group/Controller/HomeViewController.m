//
//  HomeViewController.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//


#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "Story.h"
#import "DGActivityIndicatorView.h"
#import "CommentsDetailsViewController.h"
#import "Webservice.h"

@import Firebase;
@import GoogleSignIn;

NSString *const homeViewControllerSegue =@"homeViewcontrollerSegue";

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
{
    DGActivityIndicatorView *activityIndicatorView;
    UIView *view;
    int pageIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *storiesTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *refreshedTimeLabel;
@property (strong, nonatomic) NSMutableArray *storiesArray;
@property (strong, nonatomic) Story *selectedStory;
@property (strong, nonatomic) NSMutableArray *keyArray;

@end

@implementation HomeViewController


#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

-(void)setupView{
    self.storiesArray = [NSMutableArray array];
    self.keyArray = [[NSMutableArray alloc]init];
    pageIndex = 0;
    [self.storiesTableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    [self.storiesTableView setTableFooterView:[[UIView alloc] init]];
    [self addloadingIndicator];
    [self getData];
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

- (void)getData {
    
    [view setHidden:NO];
    [view bringSubviewToFront:activityIndicatorView];
    [self.view setUserInteractionEnabled:NO];
    [activityIndicatorView startAnimating];
    [[Webservice alloc]getTopStories:^(BOOL success, NSMutableArray *objects, NSString *errorMsg) {
        if(success){
            _keyArray = objects;
            [self getStories:0];
        }
    }];
    
}

-(void)getStories:(int)pageIndex{
    NSString *key = [self.keyArray objectAtIndex:pageIndex];
    [[Webservice alloc]getStoriesForKey:key withCompletionBlock:^(BOOL success, Story *story, NSString *errorMsg) {
        if(success){
            [_storiesArray addObject:story];
            if(pageIndex == 10){
                [activityIndicatorView stopAnimating];
                [view setHidden:YES];
                [self.view setUserInteractionEnabled:YES];
                [self.storiesTableView reloadData];
            }else{
            [self getStories:pageIndex+1];
            }
        }
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storiesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    [cell setStory:[self.storiesArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedStory = [self.storiesArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:commentsDetailsViewControllerSegue sender:self];
}

#pragma mark - Perform segue methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:commentsDetailsViewControllerSegue]){
        CommentsDetailsViewController *commentViewController = segue.destinationViewController;
        commentViewController.story =  self.selectedStory;
    }
}

#pragma mark - SignOut methods

- (IBAction)signOutButtonTapped:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    [[GIDSignIn sharedInstance]signOut];
    
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

