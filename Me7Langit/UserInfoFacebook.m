//
//  UserInfoFacebook.m
//  Me7Langit
//
//  Created by ITP on 4/25/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "UserInfoFacebook.h"

@interface UserInfoFacebook()

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *hometownName;
@property (strong, nonatomic) NSString *idUserFB;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSString *about;
@property (strong, nonatomic) NSDictionary *userProfileFBDict;

@end

@implementation UserInfoFacebook

- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    if (self = [super init]) {
        _userProfileFBDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              dictionary[@"name"], @"name",
                              dictionary[@"gender"], @"gender",
                              dictionary[@"hometown"][@"name"], @"hometownName",
                              dictionary[@"id"], @"idUserFB",
                              dictionary[@"link"], @"link",
                              dictionary[@"email"], @"email",
                              dictionary[@"bio"], @"bio",
                              dictionary[@"about"], @"about", nil];
//        _name = dictionary[@"name"];
//        _gender = dictionary[@"gender"];
//        _hometownName = dictionary[@"hometown"][@"name"];
//        _idUserFB = dictionary[@"id"];
//        _link = dictionary[@"link"];
//        _email = dictionary[@"email"];
//        _bio = dictionary[@"bio"];
//        _about = dictionary[@"about"];
    }
    return self;
}

-(void)createToNSUser
{
    [[NSUserDefaults standardUserDefaults] setObject:self.userProfileFBDict forKey:@"userProfilFB"];
}

@end
