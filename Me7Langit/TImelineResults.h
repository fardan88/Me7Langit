//
//  TImelineResults.h
//  Me7Langit
//
//  Created by ITP on 4/28/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TImelineResults : NSObject

{
    NSMutableArray *idTimeline;
    NSMutableArray *from;
    NSMutableArray *status;
    NSMutableArray *createdTime;
}

@property (nonatomic, retain) NSMutableArray *idTimeline;
@property (nonatomic, retain) NSMutableArray *from;
@property (nonatomic, retain) NSMutableArray *status;
@property (nonatomic, retain) NSMutableArray *createdTime;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
-(void)addObject:(NSDictionary *)dictionary;

@end
