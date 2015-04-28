//
//  TimelineCell.m
//  Me7Langit
//
//  Created by ITP on 4/28/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "TimelineCell.h"

@interface TimelineCell()

@property (strong, nonatomic) UIView *backgroundCell;

@end

@implementation TimelineCell
@synthesize profilPicture, nameString, messageString, createStatusString;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backgroundCell = [[UIView alloc] init];
        _backgroundCell.layer.cornerRadius = 6.0;
        _backgroundCell.backgroundColor = [UIColor whiteColor];
        
        profilPicture = [[UIImageView alloc] init];
        profilPicture.backgroundColor = [UIColor grayColor];
        profilPicture.layer.cornerRadius = 6.0;
        profilPicture.layer.masksToBounds = YES;
        profilPicture.tag = 1;
        
        nameString = [[UILabel alloc] init];
        nameString.font = [UIFont fontWithName:@"Helvetica" size:18];
        nameString.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.87];
        nameString.tag = 2;
        
        messageString = [[UILabel alloc] init];
        messageString.font = [UIFont fontWithName:@"Helvetica" size:14];
        messageString.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.56];
        messageString.numberOfLines = 2;
        messageString.tag = 3;
        
        [self.contentView addSubview:self.backgroundCell];
        [self.backgroundCell addSubview:profilPicture];
        [self.backgroundCell addSubview:nameString];
        [self.backgroundCell addSubview:messageString];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews {
    _backgroundCell.frame = CGRectMake(8, 4, self.contentView.frame.size.width - 16, 0);
    profilPicture.frame = CGRectMake(8, 8, 80, 80);
    nameString.frame = CGRectMake(profilPicture.frame.origin.x + profilPicture.frame.size.width + 4, 28, self.backgroundCell.frame.size.width - (profilPicture.frame.origin.x + profilPicture.frame.size.width + 4), 20);
    messageString.frame = CGRectMake(nameString.frame.origin.x, nameString.frame.origin.y + nameString.frame.size.height + 8, nameString.frame.size.width, 40);
    _backgroundCell.frame = CGRectMake(8, 4, self.contentView.frame.size.width - 16, messageString.frame.origin.y + messageString.frame.size.height + 8);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
