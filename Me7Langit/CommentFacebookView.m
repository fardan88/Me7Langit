//
//  CommentFacebookView.m
//  Me7Langit
//
//  Created by ITP on 5/2/15.
//  Copyright (c) 2015 7Langit. All rights reserved.
//

#import "CommentFacebookView.h"

@interface CommentFacebookView ()

{
    UITextView *commentTextView;
}

@end

@implementation CommentFacebookView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:(221/255.0f) green:(221/255.0f) blue:(221/255.0f) alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(backView)];
    UIBarButtonItem *postBtn = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(postComment)];
    postBtn.tintColor = [UIColor whiteColor];
    backBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBtn;
    self.navigationItem.rightBarButtonItem = postBtn;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.text = @"Your Comment";
    titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:18];
    titleLabel.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLabel;
    [titleLabel sizeToFit];
    
    commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(8, self.navigationController.navigationBar.frame.size.height + 38, self.view.frame.size.width - 16, 100)];
    commentTextView.backgroundColor = [UIColor whiteColor];
    commentTextView.layer.cornerRadius = 6.0;
    commentTextView.layer.borderWidth = 1.0;
    commentTextView.layer.borderColor = [[UIColor colorWithRed:227 / 255.0 green:72 / 255.0 blue:47 / 255.0 alpha:1.0] CGColor];
    [self.view addSubview:commentTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)postComment {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          commentTextView.text, @"message", nil];
    NSString *urlString = [NSString stringWithFormat:@"%@/comments", self.idDetailTimeline];
    [FBRequestConnection startWithGraphPath:urlString
                                 parameters:dict
                                 HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                     if (!error) {
                                         [self dismissViewControllerAnimated:YES completion:nil];
                                     } else {
                                         
                                     }
                                 }];
}

-(void)backView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
