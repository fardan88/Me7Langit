//
//  DetailTimelineView.m
//  Me7Langit
//
//  Created by ITP on 4/29/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "DetailTimelineView.h"
#import "DetailTimeLineResult.h"

@interface DetailTimelineView ()

{
    DetailTimeLineResult *detailResult;
    UIButton *likeBtn;
}

@property (strong, nonatomic) UIScrollView *scroll;

@end

@implementation DetailTimelineView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(221/255.0f) green:(221/255.0f) blue:(221/255.0f) alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    backBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"Detail Timeline";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:18];
    titleLabel.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLabel;
    [titleLabel sizeToFit];
    [self FBGraphDetailTimeline];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width, self.view.frame.size.height - (self.navigationController.navigationBar.frame.size.height + 20))];
    _scroll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)FBGraphDetailTimeline {
    [FBRequestConnection startWithGraphPath:self.idDetailTimeline
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              detailResult = [[DetailTimeLineResult alloc] initWithDictionary:result];
                              [self viewCard];
                          }];
}

-(void)FBGraphResponseLikes {
    NSString *urlString = [NSString stringWithFormat:@"%@/likes", detailResult.idDetailTimeline];
    [FBRequestConnection startWithGraphPath:urlString
                                 parameters:nil
                                 HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                     if (!error) {
                                         NSLog(@"success");
                                         likeBtn.tintColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
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

-(void)viewCard {
    UIView *cardView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width - 16, 0)];
    cardView.backgroundColor = [UIColor whiteColor];
    cardView.layer.cornerRadius = 6.0;
    [self.scroll addSubview:cardView];
    
    UIImageView *photoProfile = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 80, 80)];
    photoProfile.backgroundColor = [UIColor grayColor];
    photoProfile.layer.masksToBounds = YES;
    photoProfile.layer.cornerRadius = photoProfile.frame.size.width / 2;
    [cardView addSubview:photoProfile];
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", detailResult.from[@"id"]];
    [self downloadImageWithURL:[NSURL URLWithString:urlString] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            photoProfile.image = image;
        }
    }];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(photoProfile.frame.origin.x + photoProfile.frame.size.width + 8, photoProfile.frame.origin.y + 30, cardView.frame.size.width - (photoProfile.frame.origin.x + photoProfile.frame.size.width + 8), 0)];
    nameLabel.numberOfLines = 0;
    nameLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.87];
    nameLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:14];
    [cardView addSubview:nameLabel];
    
    if (detailResult.story.length > 0) {
        nameLabel.text = detailResult.story;
    } else
        nameLabel.text = detailResult.from[@"name"];
    [nameLabel sizeToFit];
    
    UITextView *statusTextView = [[UITextView alloc] initWithFrame:CGRectMake(8, photoProfile.frame.origin.y + photoProfile.frame.size.height + 8, cardView.frame.size.width - 16, 0)];
    statusTextView.backgroundColor = [UIColor clearColor];
//    statusTextView.layer.cornerRadius = 3.0;
    statusTextView.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.54];
    statusTextView.font = [UIFont fontWithName:@"Helvetica" size:12];
    statusTextView.editable = NO;
    statusTextView.scrollEnabled = NO;
    [cardView addSubview:statusTextView];
    statusTextView.text = detailResult.status;
    [statusTextView sizeToFit];
    
    UITextField *totalLikesLabel = [[UITextField alloc] initWithFrame:CGRectMake(8, statusTextView.frame.origin.y + statusTextView.frame.size.height + 8, 0, 0)];
    totalLikesLabel.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    totalLikesLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    totalLikesLabel.textColor = [UIColor whiteColor];
    totalLikesLabel.layer.cornerRadius = 3.0;
    
    if (detailResult.likeCount.length > 0) {
        totalLikesLabel.text = detailResult.likeCount;
        [cardView addSubview:totalLikesLabel];
        [totalLikesLabel sizeToFit];
        totalLikesLabel.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, totalLikesLabel.frame.size.height)];
        totalLikesLabel.leftViewMode = UITextFieldViewModeAlways;
        [totalLikesLabel sizeToFit];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, totalLikesLabel.frame.origin.y + totalLikesLabel.frame.size.height + 4, cardView.frame.size.width, 2.0)];
    line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    [cardView addSubview:line];
    
    likeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    likeBtn.frame = CGRectMake(0, line.frame.origin.y + line.frame.size.height, cardView.frame.size.width / 2, 40);
    [likeBtn setTitle:@"Like" forState:UIControlStateNormal];
    [likeBtn addTarget:self action:@selector(FBGraphResponseLikes) forControlEvents:UIControlEventTouchUpInside];
    likeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    likeBtn.tintColor = [UIColor grayColor];
    [cardView addSubview:likeBtn];
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    commentBtn.frame = CGRectMake(cardView.frame.size.width / 2, line.frame.origin.y + line.frame.size.height, cardView.frame.size.width / 2, 40);
    [commentBtn setTitle:@"Comment" forState:UIControlStateNormal];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    commentBtn.tintColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    [cardView addSubview:commentBtn];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(cardView.frame.size.width / 2, line.frame.origin.y + line.frame.size.height, 2.0, likeBtn.frame.size.height)];
    line2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    [cardView addSubview:line2];
    
    cardView.frame = CGRectMake(8, 8, self.view.frame.size.width - 16, likeBtn.frame.origin.y + likeBtn.frame.size.height);
    
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width, cardView.frame.origin.y + cardView.frame.size.height + 18);
}

-(void)backView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
