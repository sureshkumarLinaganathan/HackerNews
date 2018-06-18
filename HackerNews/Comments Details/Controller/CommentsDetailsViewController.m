//
//  CommentsDetailsViewController.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "CommentsDetailsViewController.h"
#import "CommentsTableViewCell.h"
#import "Webservice.h"
#import "DGActivityIndicatorView.h"

NSString *const commentsDetailsViewControllerSegue = @"commentsDetailViewControllerSegue";

@interface CommentsDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int limit;
    DGActivityIndicatorView *activityIndicatorView;
    UIView *view;
    
}

@property (weak, nonatomic) IBOutlet UILabel *commentsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *commensButton;
@property (weak, nonatomic) IBOutlet UIButton *articleButton;
@property (assign, nonatomic) int pageIndex;
@property (strong, nonatomic) NSMutableArray *commentsArray;

@end

@implementation CommentsDetailsViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    limit = 0;
    _pageIndex = 0;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupView];
}

-(void)setupView{
    self.commentsTitleLabel.text = self.story.articleTitle;
    self.urlLabel.text = self.story.websiteURL;
    self.dateLabel.text = [NSString stringWithFormat:@"%@.%@",self.story.dateOfSubmission,self.story.submitter];
    [self addContentTowebView];
    [self.commensButton setTitle:[NSString stringWithFormat:@"%@ Comments",self.story.totalComments] forState:UIControlStateNormal];
    if([self.story.websiteURL length] == 0){
        self.articleButton.hidden = YES;
    }
    self.commentsArray = [[NSMutableArray alloc] init];
    [self addloadingIndicator];
    [self showActivityIndicator];
    [self getComments:_pageIndex];
}

#pragma mark - Web view initialization

-(void)addContentTowebView{
    self.webView = [[UIWebView alloc] initWithFrame:self.tableView.frame];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.story.websiteURL]]];
    [self.view addSubview:self.webView];
    self.webView.hidden = YES;
}

#pragma mark - Activity indicator method

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

-(void)showActivityIndicator{
    [view setHidden:NO];
    [view bringSubviewToFront:activityIndicatorView];
    [self.view setUserInteractionEnabled:NO];
    [activityIndicatorView startAnimating];
}

-(void)hideActivityIndicator{
    [activityIndicatorView stopAnimating];
    [view setHidden:YES];
    [self.view setUserInteractionEnabled:YES];
}

#pragma mark - Fetch comments

-(void)getComments:(int)pageIndex{
    limit++;
    if(pageIndex<[self.story.commentsKey count]){
        NSString *key = [self.story.commentsKey objectAtIndex:pageIndex];
        [[Webservice alloc]getCommentsForKey:key withCompletionBlock:^(BOOL success, Comment *comment, NSString *errorMsg) {
            if(success){
                [_commentsArray addObject:comment];
                if(limit == 10){
                    [self hideActivityIndicator];
                    [self.tableView reloadData];
                    limit = 0;
                }else{
                    _pageIndex++;
                    [self getComments:_pageIndex];
                }
            }else{
                _pageIndex++;
                [self getComments:_pageIndex];
            }
        }];
    }else{
        
    }
}

#pragma mark - IBActions

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)commentsButtonTapped:(id)sender {
    self.webView.hidden = YES;
    self.tableView.hidden = NO;
}
- (IBAction)aarticleButtonTapped:(id)sender {
    self.webView.hidden = NO;
    self.tableView.hidden = YES;
}

#pragma mark - Tableview Datasource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.commentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if((indexPath.row == _pageIndex)&&(_pageIndex<[self.story.commentsKey count])){
        [self showActivityIndicator];
        _pageIndex = _pageIndex+1;
        [self getComments:_pageIndex];
    }
    CommentsTableViewCell *commentsCell = [tableView dequeueReusableCellWithIdentifier:commentsTableViewCellReuseIdentifier forIndexPath:indexPath];
    Comment *comment = [self.commentsArray objectAtIndex:indexPath.row];
    [commentsCell setupView:comment];
    return commentsCell;
}



@end
