//
//  UserInfoGooglePlus.m
//  Me7Langit
//
//  Created by ITP on 5/2/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "UserInfoGooglePlus.h"

@interface UserInfoGooglePlus()

@end

@implementation UserInfoGooglePlus

-(instancetype)initWithSDKGooglePlus {
    if (self = [super init]) {
        GTLPlusPerson *person = [GPPSignIn sharedInstance].googlePlusUser;
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              person.displayName, @"name",
                              person.image.url, @"imageUrl",
                              person.cover.coverPhoto.url, @"coverUrl",
                              nil];
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"UserGooglePlus"];
    }
    return self;
}

@end
