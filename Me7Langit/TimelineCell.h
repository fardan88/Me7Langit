//
//  TimelineCell.h
//  Me7Langit
//
//  Created by ITP on 4/28/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineCell : UITableViewCell

{
    UIImageView *profilPicture;
    UILabel *nameString;
    UILabel *messageString;
    UILabel *createStatusString;
}

@property (nonatomic, retain) UIImageView *profilPicture;
@property (nonatomic, retain) UILabel *nameString;
@property (nonatomic, retain) UILabel *messageString;
@property (nonatomic, retain) UILabel *createStatusString;

@end
