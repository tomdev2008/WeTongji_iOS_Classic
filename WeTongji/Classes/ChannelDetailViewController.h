//
//  ChannelDetailViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"
#import "Activity.h"
#import "WTButton.h"

@interface ChannelDetailViewController : WTNavigationViewController

@property (nonatomic, strong) IBOutlet UILabel *organizerNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *subOrganizerNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *placeLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *activityCategoryLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet WTButton *favoriteButton;
@property (nonatomic, strong) IBOutlet WTButton *likeButton;
@property (nonatomic, strong) IBOutlet WTButton *scheduleButton;
@property (nonatomic, strong) IBOutlet UILabel *likeLabel;
@property (nonatomic, strong) IBOutlet UIView *middleView;
@property (nonatomic, strong) IBOutlet UIView *bottomView;

- (id)initWithActivity:(Activity *)activity;
- (IBAction)didClickFavoriteButton:(UIButton *)sender;
- (IBAction)didClickLikeButton:(UIButton *)sender;
- (IBAction)didClickScheduleButton:(UIButton *)sender;

@end
