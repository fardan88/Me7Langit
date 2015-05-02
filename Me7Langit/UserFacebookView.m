//
//  UserFacebookView.m
//  Me7Langit
//
//  Created by ITP on 4/25/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "UserFacebookView.h"
#import "UserInfoFacebook.h"
#import "TimelineView.h"

@interface UserFacebookView ()

{
    UIImageView *coverPhoto;
    UIImageView *photoProfile;
    UILabel *nameUserFB;
    UIView *aboutMeView;
    UITextView *aboutTextView;
    UIView *moreView;
}

@property (strong, nonatomic) UIScrollView *scroll;

@end

@implementation UserFacebookView

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    UIBarButtonItem *logoutBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    shareBtn.tintColor = [UIColor whiteColor];
    logoutBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = shareBtn;
    self.navigationItem.rightBarButtonItem = logoutBtn;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"About Me";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:18];
    titleLabel.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLabel;
    [titleLabel sizeToFit];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, self.view.bounds.size.width, self.view.frame.size.height - (self.navigationController.navigationBar.frame.size.height + 20))];
    _scroll.delegate = self;
    _scroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scroll];

    
    coverPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scroll.frame.size.width, 140)];
    coverPhoto.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    coverPhoto.layer.masksToBounds = YES;
    coverPhoto.contentMode = UIViewContentModeScaleAspectFill;
    [self.scroll addSubview:coverPhoto];
    
    photoProfile = [[UIImageView alloc] initWithFrame:CGRectMake(8, coverPhoto.frame.size.height - 40, 80, 80)];
    photoProfile.layer.masksToBounds = YES;
    photoProfile.layer.cornerRadius = photoProfile.frame.size.width / 2;
    photoProfile.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    [self.scroll addSubview:photoProfile];
    
    nameUserFB = [[UILabel alloc] initWithFrame:CGRectMake(photoProfile.frame.origin.x + photoProfile.frame.size.width + 8, photoProfile.frame.origin.y, coverPhoto.frame.size.width - (photoProfile.frame.origin.x + photoProfile.frame.size.width + 8), 40)];
    nameUserFB.numberOfLines = 0;
    nameUserFB.font = [UIFont fontWithName:@"Helvetica" size:16];
    nameUserFB.textColor = [UIColor whiteColor];
    [self.scroll addSubview:nameUserFB];
    
    [self CoverPhotoProfile];
    [self viewAboutMe];
    [self viewMore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CoverPhotoProfile
{
    [FBRequestConnection startWithGraphPath:@"me?fields=cover"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              NSString *urlString = [NSString stringWithFormat:@"%@", result[@"cover"][@"source"]];
                              NSString *urlStringPhotoProfile = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [[NSUserDefaults standardUserDefaults] objectForKey:@"userProfilFB"][@"idUserFB"]];
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  NSData *imgCoverData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                                  NSData *imgPhotoProfileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringPhotoProfile]];
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      coverPhoto.image = [UIImage imageWithData:imgCoverData];
                                      photoProfile.image = [UIImage imageWithData:imgPhotoProfileData];
                                      nameUserFB.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userProfilFB"][@"name"];
                                  });
                              });
                          }];
}

-(void)viewAboutMe
{
    aboutMeView = [[UIView alloc] initWithFrame:CGRectMake(8, photoProfile.frame.origin.y + photoProfile.frame.size.height + 8, self.scroll.frame.size.width - 16, 200)];
    aboutMeView.layer.masksToBounds = NO;
    aboutMeView.backgroundColor = [UIColor whiteColor];
    aboutMeView.layer.borderColor = [[UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0] CGColor];
    aboutMeView.layer.shadowColor = [[UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0] CGColor];
    aboutMeView.layer.shadowOpacity = 0.7;
    aboutMeView.layer.shadowRadius = 1.0;
    aboutMeView.layer.borderWidth = 1.0;
    aboutMeView.layer.cornerRadius = 6.0;
    [self.scroll addSubview:aboutMeView];
    
    UILabel *aboutMeLabel = [[UILabel alloc] initWithFrame:CGRectMake(aboutMeView.frame.origin.x, aboutMeView.frame.origin.y - 28, aboutMeView.frame.size.width, 20)];
    aboutMeLabel.text = @"About Me...";
    aboutMeLabel.textAlignment = NSTextAlignmentRight;
    aboutMeLabel.font = [UIFont fontWithName:@"Menlo-Bold" size:18];
    aboutMeLabel.textColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    [self.scroll addSubview:aboutMeLabel];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 0, 0)];
    nameLabel.text = @"Name:";
    nameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    nameLabel.textColor = [UIColor blackColor];
    [aboutMeView addSubview:nameLabel];
    [nameLabel sizeToFit];
    
    UITextView *nameTextView = [[UITextView alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y + nameLabel.frame.size.height + 4, aboutMeView.frame.size.width - 16, 0)];
    nameTextView.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userProfilFB"][@"name"];
    nameTextView.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    nameTextView.layer.cornerRadius = 3.0;
    nameTextView.textColor = [UIColor whiteColor];
    nameTextView.font = [UIFont fontWithName:@"Helvetica" size:14];
    nameTextView.editable = NO;
    nameTextView.scrollEnabled = NO;
    [aboutMeView addSubview:nameTextView];
    [nameTextView sizeToFit];
    
    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, nameTextView.frame.origin.y + nameTextView.frame.size.height + 8, 0, 0)];
    genderLabel.text = @"Gender:";
    genderLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    genderLabel.textColor = [UIColor blackColor];
    [aboutMeView addSubview:genderLabel];
    [genderLabel sizeToFit];
    
    UITextView *genderTextView = [[UITextView alloc] initWithFrame:CGRectMake(genderLabel.frame.origin.x, genderLabel.frame.origin.y + genderLabel.frame.size.height + 4, aboutMeView.frame.size.width - 16, 0)];
    genderTextView.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userProfilFB"][@"gender"];
    genderTextView.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    genderTextView.layer.cornerRadius = 3.0;
    genderTextView.textColor = [UIColor whiteColor];
    genderTextView.font = [UIFont fontWithName:@"Helvetica" size:14];
    genderTextView.editable = NO;
    genderTextView.scrollEnabled = NO;
    [aboutMeView addSubview:genderTextView];
    [genderTextView sizeToFit];
    
    UILabel *hometownLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, genderTextView.frame.origin.y + genderTextView.frame.size.height + 8, 0, 0)];
    hometownLabel.text = @"Hometown:";
    hometownLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    hometownLabel.textColor = [UIColor blackColor];
    [aboutMeView addSubview:hometownLabel];
    [hometownLabel sizeToFit];
    
    UITextView *hometownTextView = [[UITextView alloc] initWithFrame:CGRectMake(hometownLabel.frame.origin.x, hometownLabel.frame.origin.y + hometownLabel.frame.size.height + 4, aboutMeView.frame.size.width - 16, 0)];
    hometownTextView.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userProfilFB"][@"hometownName"];
    hometownTextView.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    hometownTextView.layer.cornerRadius = 3.0;
    hometownTextView.textColor = [UIColor whiteColor];
    hometownTextView.font = [UIFont fontWithName:@"Helvetica" size:14];
    hometownTextView.editable = NO;
    hometownTextView.scrollEnabled = NO;
    [aboutMeView addSubview:hometownTextView];
    [hometownTextView sizeToFit];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, hometownTextView.frame.origin.y + hometownTextView.frame.size.height + 8, 0, 0)];
    emailLabel.text = @"Email:";
    emailLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    emailLabel.textColor = [UIColor blackColor];
    [aboutMeView addSubview:emailLabel];
    [emailLabel sizeToFit];
    
    UITextView *emailTextView = [[UITextView alloc] initWithFrame:CGRectMake(emailLabel.frame.origin.x, emailLabel.frame.origin.y + emailLabel.frame.size.height + 4, aboutMeView.frame.size.width - 16, 0)];
    emailTextView.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userProfilFB"][@"email"];
    emailTextView.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    emailTextView.layer.cornerRadius = 3.0;
    emailTextView.textColor = [UIColor whiteColor];
    emailTextView.font = [UIFont fontWithName:@"Helvetica" size:14];
    emailTextView.editable = NO;
    emailTextView.scrollEnabled = NO;
    [aboutMeView addSubview:emailTextView];
    [emailTextView sizeToFit];
    
    UILabel *aboutLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, emailTextView.frame.origin.y + emailTextView.frame.size.height + 8, 0, 0)];
    aboutLabel.text = @"About Me:";
    aboutLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    aboutLabel.textColor = [UIColor blackColor];
    [aboutMeView addSubview:aboutLabel];
    [aboutLabel sizeToFit];
    
    aboutTextView = [[UITextView alloc] initWithFrame:CGRectMake(aboutLabel.frame.origin.x, aboutLabel.frame.origin.y + aboutLabel.frame.size.height + 4, aboutMeView.frame.size.width - 16, 0)];
    aboutTextView.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userProfilFB"][@"about"];
    aboutTextView.backgroundColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    aboutTextView.layer.cornerRadius = 3.0;
    aboutTextView.textColor = [UIColor whiteColor];
    aboutTextView.font = [UIFont fontWithName:@"Helvetica" size:14];
    aboutTextView.editable = NO;
    aboutTextView.scrollEnabled = NO;
    [aboutMeView addSubview:aboutTextView];
    [aboutTextView sizeToFit];
    
    aboutMeView.frame = CGRectMake(8, photoProfile.frame.origin.y + photoProfile.frame.size.height + 8, self.scroll.frame.size.width - 16, aboutTextView.frame.origin.y + aboutTextView.frame.size.height + 8);
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width, aboutMeView.frame.origin.y + aboutMeView.frame.size.height + 18);
}

-(void)viewMore
{
    UILabel *morelabel = [[UILabel alloc] initWithFrame:CGRectMake(8, aboutMeView.frame.origin.y + aboutMeView.frame.size.height + 8, self.view.frame.size.width - 16, 20)];
    morelabel.text = @"More";
    morelabel.textAlignment = NSTextAlignmentRight;
    morelabel.font = [UIFont fontWithName:@"Menlo-Bold" size:18];
    morelabel.textColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    [self.scroll addSubview:morelabel];
    
    moreView = [[UIView alloc] initWithFrame:CGRectMake(8, morelabel.frame.origin.y + morelabel.frame.size.height + 8, self.scroll.frame.size.width - 16, 200)];
    moreView.layer.masksToBounds = NO;
    moreView.backgroundColor = [UIColor whiteColor];
    moreView.layer.borderColor = [[UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0] CGColor];
    moreView.layer.shadowColor = [[UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0] CGColor];
    moreView.layer.shadowOpacity = 0.7;
    moreView.layer.shadowRadius = 1.0;
    moreView.layer.borderWidth = 1.0;
    moreView.layer.cornerRadius = 6.0;
    [self.scroll addSubview:moreView];
    
    UIImageView *profilPicture7Langit = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 80, 80)];
    profilPicture7Langit.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    profilPicture7Langit.layer.masksToBounds = YES;
    profilPicture7Langit.layer.cornerRadius = 3.0;
    [moreView addSubview:profilPicture7Langit];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *urlStringPhotoProfile = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", FBid7Langit];
        NSData *imgData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlStringPhotoProfile]];
        dispatch_async(dispatch_get_main_queue(), ^{
            profilPicture7Langit.image = [UIImage imageWithData:imgData];
        });
    });
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(profilPicture7Langit.frame.origin.x + profilPicture7Langit.frame.size.width + 8, 8, moreView.frame.size.width - (profilPicture7Langit.frame.origin.x + profilPicture7Langit.frame.size.width + 8), profilPicture7Langit.frame.size.height)];
    nameLabel.text = @"7Langit Timeline";
    nameLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
    nameLabel.textColor = [UIColor blackColor];
    [moreView addSubview:nameLabel];
    
    moreView.frame = CGRectMake(8, morelabel.frame.origin.y + morelabel.frame.size.height + 8, self.scroll.frame.size.width - 16, profilPicture7Langit.frame.origin.y + profilPicture7Langit.frame.size.height + 8);
    
    UIButton *goTimelineBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goTimelineBtn.frame = CGRectMake(0, 0, moreView.frame.size.width, moreView.frame.size.height);
    [goTimelineBtn addTarget:self action:@selector(timeline7langit) forControlEvents:UIControlEventTouchUpInside];
    [moreView addSubview:goTimelineBtn];
    
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width, moreView.frame.origin.y + moreView.frame.size.height + 18);
}

-(void)timeline7langit
{
    TimelineView *timeline7Langit = [[TimelineView alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:timeline7Langit];
    [self presentViewController:nvc animated:YES completion:nil];
}

-(void)share
{
    
}

-(void)logout
{
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userProfilFB"];
    }];
}

//-(NSUInteger)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskLandscape;
//}
//
//- (BOOL)shouldAutorotate {
//    return YES;
//}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
//                                duration:(NSTimeInterval)duration{
//    if (UIInterfaceOrientationIsPortrait(orientation)) {
////        coverPhoto.frame = CGRectMake(0, 0, self.scroll.frame.size.width, 140);
////        aboutMeView.frame = CGRectMake(8, photoProfile.frame.origin.y + photoProfile.frame.size.height + 8, self.scroll.frame.size.width - 16, aboutTextView.frame.origin.y + aboutTextView.frame.size.height + 8);
////        _scroll.contentSize = CGSizeMake(self.view.frame.size.width, aboutMeView.frame.origin.y + aboutMeView.frame.size.height + 18);
//    } else {
//        
//    }
//}

@end
