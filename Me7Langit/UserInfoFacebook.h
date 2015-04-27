//
//  UserInfoFacebook.h
//  Me7Langit
//
//  Created by ITP on 4/25/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoFacebook : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
-(void)createToNSUser;

@end
