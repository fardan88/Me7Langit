//
//  TImelineResults.m
//  Me7Langit
//
//  Created by ITP on 4/28/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "TImelineResults.h"

@interface TImelineResults()

@property (strong, nonatomic) NSDictionary *results;

@end

@implementation TImelineResults
@synthesize idTimeline, from, status, createdTime;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    idTimeline = [[NSMutableArray alloc] init];
    from = [[NSMutableArray alloc] init];
    status = [[NSMutableArray alloc] init];
    createdTime = [[NSMutableArray alloc] init];
    if (self = [super init]) {
        for (int i = 0; i < [dictionary[@"data"] count]; i++) {
            [idTimeline addObject:[NSString stringWithFormat:@"%@", dictionary[@"data"][i][@"id"]]];
            [from addObject:dictionary[@"data"][i][@"from"]];
            [status addObject:[NSString stringWithFormat:@"%@", dictionary[@"data"][i][@"message"]]];
            [createdTime addObject:[NSString stringWithFormat:@"%@", dictionary[@"data"][i][@"created_time"]]];
        }
        [[NSUserDefaults standardUserDefaults] setValue:dictionary[@"paging"][@"next"] forKey:@"nextPage"];
    }
    return self;
}

-(void)addObject:(NSDictionary *)dictionary
{
    for (int i = 0; i < [dictionary[@"data"] count]; i++) {
        [idTimeline addObject:[NSString stringWithFormat:@"%@", dictionary[@"data"][i][@"id"]]];
        [from addObject:dictionary[@"data"][i][@"from"]];
        [status addObject:[NSString stringWithFormat:@"%@", dictionary[@"data"][i][@"message"]]];
        [createdTime addObject:[NSString stringWithFormat:@"%@", dictionary[@"data"][i][@"created_time"]]];
    }
    [[NSUserDefaults standardUserDefaults] setValue:dictionary[@"paging"][@"next"] forKey:@"nextPage"];
}

@end
