//
//  PopSettingsView.h
//  PopSettings
//
//  Created by Alfie on 16/7/30.
//  Copyright © 2016年 Alfie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopSettingsView : UIView

@property (nonatomic,weak) UIView *contentView;

+ (void)popSettingsViewForSender:(UIView *)sender inView:(UIView *)view;
+ (void)dismissPopView;

@end
