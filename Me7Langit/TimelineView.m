//
//  TimelineView.m
//  Me7Langit
//
//  Created by ITP on 4/28/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "TimelineView.h"
#import "TimelineCell.h"
#import "TImelineResults.h"

@interface TimelineView ()

{
    UIImageView *coverPhoto;
    UIImageView *profilPicture7Langit;
    UILabel *nameLabel;
    UILabel *generalInfoLabel;
    TImelineResults *dict;
}

@property (strong, nonatomic) UITableView *timelineTableView;
@property (strong, nonatomic) NSMutableDictionary *timelineResults;

@end

static NSString * const FBid7Langit = @"177321525623964";

@implementation TimelineView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(221/255.0f) green:(221/255.0f) blue:(221/255.0f) alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    backBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"Timeline 7Langit";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:18];
    titleLabel.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLabel;
    [titleLabel sizeToFit];
    
    coverPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width, 140)];
    coverPhoto.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    coverPhoto.layer.masksToBounds = YES;
    coverPhoto.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:coverPhoto];
    
    profilPicture7Langit = [[UIImageView alloc] initWithFrame:CGRectMake(8, coverPhoto.frame.origin.y + coverPhoto.frame.size.height - 60, 80, 80)];
    profilPicture7Langit.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    profilPicture7Langit.layer.masksToBounds = YES;
    profilPicture7Langit.layer.cornerRadius = 3.0;
    profilPicture7Langit.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.view addSubview:profilPicture7Langit];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(profilPicture7Langit.frame.origin.x + profilPicture7Langit.frame.size.width + 4, profilPicture7Langit.frame.origin.y, self.view.frame.size.width - 8 - (profilPicture7Langit.frame.origin.x + profilPicture7Langit.frame.size.width + 4), 16)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.backgroundColor = [[UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0] colorWithAlphaComponent:0.56];
    nameLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:14];
    
    
    generalInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + nameLabel.frame.size.height + 4, nameLabel.frame.size.width, 40)];
    generalInfoLabel.numberOfLines = 2;
    generalInfoLabel.textColor = [UIColor whiteColor];
    generalInfoLabel.backgroundColor = [[UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0] colorWithAlphaComponent:0.56];
    generalInfoLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    
    _timelineTableView = [[UITableView alloc] initWithFrame:CGRectMake(8, profilPicture7Langit.frame.origin.y + profilPicture7Langit.frame.size.height + 4, self.view.frame.size.width - 16, self.view.frame.size.height - (profilPicture7Langit.frame.origin.y + profilPicture7Langit.frame.size.height + 4 + 8)) style:UITableViewStylePlain];
    _timelineTableView.delegate = self;
    _timelineTableView.dataSource = self;
    _timelineTableView.rowHeight = 112;
    _timelineTableView.separatorColor = [UIColor clearColor];
    _timelineTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.timelineTableView];
    
    _timelineResults = [[NSMutableDictionary alloc] init];
    
    [self coverPhoto];
    [self FBGraph7Langit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)coverPhoto
{
    [FBRequestConnection startWithGraphPath:[NSString stringWithFormat:@"%@", FBid7Langit]
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              NSString *urlString = [NSString stringWithFormat:@"%@", result[@"cover"][@"source"]];
                              NSString *urlStringPhotoProfile = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", FBid7Langit];
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  NSData *imgCoverData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                                  NSData *imgPhotoProfileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringPhotoProfile]];
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      coverPhoto.image = [UIImage imageWithData:imgCoverData];
                                      profilPicture7Langit.image = [UIImage imageWithData:imgPhotoProfileData];
                                      nameLabel.text = result[@"username"];
                                      [nameLabel sizeToFit];
                                      generalInfoLabel.text = result[@"general_info"];
                                      [generalInfoLabel sizeToFit];
                                      [self.view addSubview:nameLabel];
                                      [self.view addSubview:generalInfoLabel];
                                  });
                              });
                          }];
}

-(void)FBGraph7Langit
{
    [FBRequestConnection startWithGraphPath:[NSString stringWithFormat:@"%@/feed?limit=10", FBid7Langit]
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              dict = [[TImelineResults alloc] initWithDictionary:result];
                              [self.timelineTableView reloadData];
                          }];
}

-(void)FBGraphNextPage
{
    NSString *nextString = [[NSUserDefaults standardUserDefaults] objectForKey:@"nextPage"];
    nextString = [nextString stringByReplacingOccurrencesOfString:@"https://graph.facebook.com/v2.3/" withString:@""];
    [FBRequestConnection startWithGraphPath:[NSString stringWithFormat:@"%@", nextString]
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if ([result[@"data"] count] > 0) {
                                  [dict addObject:result];
                                  [self.timelineTableView reloadData];
                              }
                          }];
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

-(void)backView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dict.from count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TimelineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[TimelineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (dict) {
        cell.nameString.text = dict.from[indexPath.row][@"name"];
        cell.messageString.text = dict.status[indexPath.row];
        NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", dict.from[indexPath.row][@"id"]];
        [self downloadImageWithURL:[NSURL URLWithString:urlString] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                cell.profilPicture.image = image;
            }
        }];
    }
    
    if (indexPath.row == [dict.from count] / 3) {
        [self FBGraphNextPage];
    }
    
    return cell;
}

@end
