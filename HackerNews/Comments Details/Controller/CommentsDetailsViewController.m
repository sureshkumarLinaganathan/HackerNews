//
//  CommentsDetailsViewController.m
//  HackerNews
//
//  Created by Sureshkumar Linganathan on 6/18/18.
//  Copyright © 2018 Omnify. All rights reserved.
//

#import "CommentsDetailsViewController.h"
#import "CommentsTableViewCell.h"

NSString *const commentsDetailsViewControllerSegue = @"commentsDetailViewControllerSegue";

@interface CommentsDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *commentsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation CommentsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}

-(void)setupView{
    self.commentsTitleLabel.text = self.story.articleTitle;
    self.urlLabel.text = self.story.websiteURL;
    self.dateLabel.text = self.story.dateOfSubmission;
    
    self.webView = [[UIWebView alloc] initWithFrame:self.tableView.frame];
    [self.view addSubview:self.webView];
    self.webView.hidden = YES;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentsTableViewCell *commentsCell = [tableView dequeueReusableCellWithIdentifier:commentsTableViewCellReuseIdentifier forIndexPath:indexPath];
    [commentsCell setupView];
    return commentsCell;
}



@end
