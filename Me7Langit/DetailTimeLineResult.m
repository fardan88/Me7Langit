//
//  DetailTimeLineResult.m
//  Me7Langit
//
//  Created by ITP on 4/29/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "DetailTimeLineResult.h"

@implementation DetailTimeLineResult
@synthesize idDetailTimeline, from, status, story, pictureUrl, idObject, createdTime, actionComment, actionLike, likeCount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        idDetailTimeline = dictionary[@"id"];
        from = dictionary[@"from"];
        status = dictionary[@"message"];
        story = dictionary[@"story"];
        pictureUrl = dictionary[@"picture"];
        idObject = dictionary[@"object_id"];
        createdTime = dictionary[@"created_time"];
        actionComment = dictionary[@"action"][0][@"link"];
        actionLike = dictionary[@"action"][1][@"link"];
        likeCount = [NSString stringWithFormat:@"%lu people like this", (unsigned long)[dictionary[@"likes"][@"data"] count]];
    }
    return self;
}

@end
