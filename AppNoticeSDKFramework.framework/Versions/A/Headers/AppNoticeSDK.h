//
//  AppNoticeSDKFramework.h
//  AppNoticeSDK
//
//  Copyright (c) 2015 Ghostery, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNoticeSDKConfiguration;

typedef enum : NSUInteger {
    AppNoticeConsentNeeded,     // consent is needed
    AppNoticeConsentAccepted,   // consent given
    AppNoticeConsentDeclined,   // consent declined
    AppNoticeConsentSkipped,    // consent previously shown
} AppNoticeConsent;

NS_ASSUME_NONNULL_BEGIN
typedef void (^AppNoticeSDKPreferencesClosedBlock)();
typedef void (^AppNoticeSDKConsentFlowCompletionBlock)(AppNoticeConsent result, NSDictionary *trackers);
typedef void (^AppNoticeSDKSessionCompletionBlock)(NSDictionary *resultsDict, NSError *error);


@interface AppNoticeSDK : NSObject

+ (instancetype)sharedInstance;

/** 
   Activates the SDK with your company id and pub notice id. Must be called before using SDK
 
   @param companyId The company id which was provided to you by Ghostery
   @param pubNoticeId The pub notice id which you created on the web portal
 
 */
- (void)activateWithCompanyId:(NSString*)companyId pubNoticeId:(NSString*)pubNoticeId;


/** 
   Presents the user with an explicit consent dialog.
 
   @param onClose The on close block to be called after the dialog is closed
   @param presentingViewController The UIViewController that the preferences screen will be presented from (if the user opens the preferences from the consent dialog)
 
 */
- (void)showExplicitConsentFlowWithOnClose:(AppNoticeSDKConsentFlowCompletionBlock)onClose presentingViewController:(UIViewController*)vc;

/**
 Presents the user with an implied consent dialog.
 
 @param onClose The on close block to be called after the dialog is closed
 @param presentingViewController The UIViewController that the preferences screen will be presented from (if the user opens the preferences from the consent dialog)
 @param repeatEvery30Days Causes the consent dialog to be shown every 30 days.
 
 */
- (void)showConsentFlowWithOnClose:(AppNoticeSDKConsentFlowCompletionBlock)onClose presentingViewController:(UIViewController*)vc repeatEvery30Days:(BOOL)repeat;

/**
   Presents the user the preferences view controller. The preferences view controller allows the user to toggle trackers. A UINavigationController is presented modally from the view controller you pass in, keep this in mind in your application design.
 
   @param onClose The on close block to be called after the dialog is closed
   @param presentingViewController The UIViewController that you will present the preferences from
 
 */
- (void)showManagePreferences:(AppNoticeSDKPreferencesClosedBlock)onClose presentingViewController:(UIViewController*)vc;

/**
   Gets the most recent/updated tracker preferences. Grab this prior to toggling trackers.
 
   @return The dictionary of trackers where the key is a string representing the unique Ghostery Ad Id and where the value is an boolean NSNumber where 0 is off and 1 is on
 */
- (NSDictionary *)getTrackerPreferences;


/** 
   Resets count on consent dialog appearances and resets all tracker settings for user
 */
- (void)resetSDK;

@end
NS_ASSUME_NONNULL_END
