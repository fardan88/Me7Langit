//
//  DetailTimeLineResult.h
//  Me7Langit
//
//  Created by ITP on 4/29/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailTimeLineResult : NSObject

{
    NSString *idDetailTimeline;
    NSDictionary *from;
    NSString *status;
    NSString *story;
    NSString *pictureUrl;
    NSString *idObject;
    NSString *createdTime;
    NSString *actionLike;
    NSString *actionComment;
    NSString *likeCount;
}

@property (nonatomic, retain) NSString *idDetailTimeline;
@property (nonatomic, retain) NSDictionary *from;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *story;
@property (nonatomic, retain) NSString *pictureUrl;
@property (nonatomic, retain) NSString *idObject;
@property (nonatomic, retain) NSString *createdTime;
@property (nonatomic, retain) NSString *actionLike;
@property (nonatomic, retain) NSString *actionComment;
@property (nonatomic, retain) NSString *likeCount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
