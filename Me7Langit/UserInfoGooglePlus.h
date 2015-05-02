//
//  UserInfoGooglePlus.h
//  Me7Langit
//
//  Created by ITP on 5/2/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GooglePlus.framework/Headers/GPPSignIn.h"
#import "GoogleOpenSource.framework/Headers/GTLPlusPerson.h"

@interface UserInfoGooglePlus : NSObject

- (instancetype)initWithSDKGooglePlus;

@end
