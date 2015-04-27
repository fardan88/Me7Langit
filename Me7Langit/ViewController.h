//
//  ViewController.h
//  Me7Langit
//
//  Created by ITP on 4/25/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GooglePlus.framework/Headers/GPPSignIn.h"

static NSString * const kClientId = @"992035817176-cvb3s1ml6eq3gc8tbbgt7ljkjg4bnglm.apps.googleusercontent.com";

@class GPPSignInButton;
@interface ViewController : UIViewController <FBLoginViewDelegate, GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;

@end