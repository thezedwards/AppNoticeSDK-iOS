//
//  ViewController.m
//  Triangle
//
//  Created by Steve Overson on 8/25/15.
//  Copyright (c) 2015 Ghostery. All rights reserved.
//

#define ADMOB_ID @"464"

@import UIKit;
@import GoogleMobileAds;

#import "ViewController.h"
#import <AppNoticeSDKFramework/AppNoticeSDKFramework.h>

@interface ViewController ()
@property (nonatomic) NSDictionary *trackers;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AppNoticeSDK sharedInstance]showConsentFlowWithOnClose:^(BOOL consentAccepted, BOOL consentSkipped, NSDictionary * _Nonnull trackers) {
        
        //Handle what you want to do if the user gives consent or not. This is also where you can decide which trackers/ads to use/show based on the trackersArray preferences
        
        //The trackers available to your application. Each tracker has an id and a status. The id is the unique id for that tracker, and the status is a boolean value of on or off
        NSLog(@"Trackers: %@",[trackers debugDescription]);
        
        self.trackers = trackers;
        
        [self toggleTrackers];
    } presentingViewController:self];
}

//You will want to toggle all of your trackers in a similar manner based on the user's tracker preferences. Ensure that the trackers are not working behind the scenes
//even if you have hidden the UI. You don't want any communications from and to the trackers if toggled off
- (void)toggleTrackers {
    
    // The trackers dictionary is formatted like this: "464": 1
    // Where "464" is a String key representing the unique Ghostery Ad Id and where 1 is an NSNumber Boolean value - 0 is off and 1 is on
    NSNumber *adMobStatus = [self.trackers objectForKey:ADMOB_ID];
    
    if (adMobStatus) {
        
        //If tracker active turn on ad
        if ([adMobStatus boolValue]) {
            // Replace this ad unit ID with your own ad unit ID.
            self.bannerView.hidden = NO;
            self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
            self.bannerView.rootViewController = self;
            
            GADRequest *request = [GADRequest request];
            
            request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"];
            [self.bannerView loadRequest:request];
        } else {
            //Turn off tracker
            self.bannerView.adUnitID = nil;
            self.bannerView.rootViewController = nil;
            self.bannerView.hidden = YES;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openPrefs:(id)sender {
    
    [[AppNoticeSDK sharedInstance]showManagePreferences:^{
        //Handle what you want to do after the preferences screen is closed
        
        //Get the newly updated tracker preferences
        self.trackers = [[AppNoticeSDK sharedInstance]getTrackerPreferences];
        
        [self toggleTrackers];
    } presentingViewController:self];
}

@end
