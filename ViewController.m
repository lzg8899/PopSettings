//
//  ViewController.m
//  PopSettings
//
//  Created by Alfie on 16/7/30.
//  Copyright © 2016年 Alfie. All rights reserved.
//

#import "ViewController.h"
#import "PopSettingsView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *popActionButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)popAction:(id)sender
{
    [PopSettingsView popSettingsViewForSender:sender inView:self.view];
}


@end
