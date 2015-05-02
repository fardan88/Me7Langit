//
//  UserGooglePlusView.m
//  Me7Langit
//
//  Created by ITP on 5/2/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "UserGooglePlusView.h"

@interface UserGooglePlusView ()

{
    UIImageView *coverPhoto;
    UIImageView *photoProfile;
}

@property (strong, nonatomic) UIScrollView *scroll;

@end

@implementation UserGooglePlusView

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
    
    UIView *transpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, coverPhoto.frame.size.width / 2, coverPhoto.frame.size.height)];
    transpView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.54];
    [coverPhoto addSubview:transpView];
    
    photoProfile = [[UIImageView alloc] initWithFrame:CGRectMake((coverPhoto.frame.size.width / 4) - 40, 8, 80, 80)];
    photoProfile.layer.masksToBounds = YES;
    photoProfile.layer.cornerRadius = photoProfile.frame.size.width / 2;
    photoProfile.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    [coverPhoto addSubview:photoProfile];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, photoProfile.frame.origin.y + photoProfile.frame.size.height, transpView.frame.size.width - 8, coverPhoto.frame.size.height - (photoProfile.frame.origin.y + photoProfile.frame.size.height))];
    nameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserGooglePlus"][@"name"];
    nameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    nameLabel.numberOfLines = 0;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [coverPhoto addSubview:nameLabel];
    [self CoverPhotoProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CoverPhotoProfile
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *urlPhotoProfileString = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UserGooglePlus"][@"imageUrl"]];
        NSString *urlPhotoCoverString = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UserGooglePlus"][@"coverUrl"]];
        
        NSData *photoProfileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlPhotoProfileString]];
        NSData *photoCoverData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlPhotoCoverString]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            photoProfile.image = [UIImage imageWithData:photoProfileData];
            coverPhoto.image = [UIImage imageWithData:photoCoverData];
        });
    });
}

-(void)share {
    
}

-(void)logout {
    [[GPPSignIn sharedInstance] signOut];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserGooglePlus"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
