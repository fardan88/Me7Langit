//
//  ViewController.m
//  Me7Langit
//
//  Created by ITP on 4/25/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "ViewController.h"
#import "UserFacebookView.h"
#import "UserInfoFacebook.h"
#import "GoogleOpenSource.framework/Headers/GTLPlusConstants.h"
#import "GooglePlus.framework/Headers/GPPSignInButton.h"

@interface ViewController ()

{
    UIImageView *backgroundImg;
}

@end

@implementation ViewController
@synthesize signInButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [[UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0] colorWithAlphaComponent:0.86];
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
//    [self.view addSubview:blurView];
    backgroundImg = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    backgroundImg.image = [UIImage imageNamed:@"background-mainView"];
    [self.view addSubview:backgroundImg];
    
    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40, 80, 80, 80)];
    logoImg.backgroundColor = [UIColor grayColor];
    logoImg.image = [UIImage imageNamed:@"icon"];
    logoImg.layer.cornerRadius = 6.0;
    logoImg.layer.borderWidth = 2.0;
    logoImg.layer.borderColor = [[UIColor whiteColor] CGColor];
    logoImg.layer.masksToBounds = YES;
    [self.view addSubview:logoImg];
    
    [self viewLoginScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewLoginScreen
{
    FBLoginView *facebookLoginBtn = [[FBLoginView alloc] init];
    signInButton = [[GPPSignInButton alloc] init];
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - (facebookLoginBtn.frame.size.height + signInButton.frame.size.height) - (8 * 4) - 36, self.view.frame.size.width, 20)];
    firstLabel.text = @"Login with?";
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.font = [UIFont fontWithName:@"Menlo-Bold" size:18];
    firstLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:firstLabel];
    
    facebookLoginBtn.delegate = self;
    facebookLoginBtn.frame = CGRectMake(self.view.frame.size.width / 2 - (218 / 2), firstLabel.frame.origin.y + firstLabel.frame.size.height + 8, 218, 46);
    facebookLoginBtn.readPermissions = @[@"user_about_me", @"email", @"user_birthday", @"user_hometown", @"user_photos", @"publish_actions"];
    [self.view addSubview:facebookLoginBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(facebookLoginBtn.frame.origin.x, facebookLoginBtn.frame.origin.y + facebookLoginBtn.frame.size.height + 14, facebookLoginBtn.frame.size.width / 2 - 15, 1)];
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(line.frame.origin.x + line.frame.size.width, facebookLoginBtn.frame.origin.y + facebookLoginBtn.frame.size.height + 4, 30, 16)];
    secondLabel.text = @"or";
    secondLabel.textAlignment = NSTextAlignmentCenter;
    secondLabel.font = [UIFont fontWithName:@"Menlo" size:14];
    secondLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:secondLabel];
    
    UIView *secondLine = [[UIView alloc] initWithFrame:CGRectMake(secondLabel.frame.origin.x + secondLabel.frame.size.width, line.frame.origin.y, facebookLoginBtn.frame.size.width / 2 - 15, 1)];
    secondLine.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondLine];
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    // Anda sebelumnya menetapkan kClientID di langkah "Mempersiapkan klien Google+"
    signIn.clientID = kClientId;
    signIn.scopes = [NSArray arrayWithObjects:
                     kGTLAuthScopePlusLogin, // yang ditetapkan di GTLPlusConstants.h
                     nil];
    signIn.delegate = self;
    
    signInButton.frame = CGRectMake(self.view.frame.size.width / 2 - (148 / 2), secondLabel.frame.origin.y + secondLabel.frame.size.height + 4, 148, 48);
    [self.view addSubview:signInButton];
    [signIn trySilentAuthentication];
    
//    UIButton *signOutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    signOutBtn.frame = CGRectMake(80, 120, 100, 100);
//    [signOutBtn setTitle:@"Sign Out" forState:UIControlStateNormal];
//    [signOutBtn addTarget:self action:@selector(signOut) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:signOutBtn];
}

#pragma mark - FBLoginViewDelegate

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{    
    [FBRequestConnection startWithGraphPath:@"me"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              UserInfoFacebook *createProfilUser = [[UserInfoFacebook alloc] initWithDictionary:result];
                              [createProfilUser createToNSUser];
                              UserFacebookView *userFBView = [[UserFacebookView alloc] init];
                              UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:userFBView];
                              [self presentViewController:nvc animated:YES completion:nil];
                          }];
}

#pragma mark - GPPSignInViewDelegate

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Lakukan beberapa penanganan kesalahan di sini.
    } else {
        [self refreshInterfaceBasedOnSignIn];
    }
}

-(void)refreshInterfaceBasedOnSignIn
{
    if ([[GPPSignIn sharedInstance] authentication]) {
        // Pengguna masuk.
        self.signInButton.hidden = YES;
        // Lakukan tindakan lain di sini, seperti menampilkan tombol masuk
    } else {
        self.signInButton.hidden = NO;
        // Lakukan tindakan lain di sini
    }
}

- (void)signOut {
    [[GPPSignIn sharedInstance] signOut];
}

@end
