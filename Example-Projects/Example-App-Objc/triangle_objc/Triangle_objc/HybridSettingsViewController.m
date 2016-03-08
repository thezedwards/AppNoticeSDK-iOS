//
//  HybridSettingsViewController.m
//  Triangle_objc
//
//  Created by Joe Swindler on 3/7/16.
//  Copyright © 2016 Ghostery. All rights reserved.
//

#import "HybridSettingsViewController.h"
#import <AppNoticeSDKFramework/AppNoticeSDKFramework.h>

@interface HybridSettingsViewController ()

@end

@implementation HybridSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)inAppPrivacyButtonPressed:(id)sender {
    [[AppNoticeSDK sharedInstance] showManagePreferences:^{
        //Handle what you want to do after the preferences screen is closed
    } presentingViewController:self];
}

@end
