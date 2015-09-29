//
//  AppNoticeSDKFramework.h
//  AppNoticeSDK
//
//  Copyright (c) 2015 Ghostery, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppNoticeSDKConfiguration;

NS_ASSUME_NONNULL_BEGIN
typedef void (^AppNoticeSDKPreferencesClosedBlock)();
typedef void (^AppNoticeSDKConsentFlowCompletionBlock)(BOOL consentAccepted, BOOL consentSkipped, NSDictionary *trackers);
typedef void (^AppNoticeSDKSessionCompletionBlock)(NSDictionary *resultsDict, NSError *error);

@interface AppNoticeSDK : NSObject

+(instancetype)sharedInstance;

/**
 Determines whether the app should use values from the server (remote) or values from the local Configuration.plist file. Default value is `YES/true`
 */
@property (nonatomic, assign) BOOL useRemoteValues;


/** 
   Activates the SDK with your company id and pub notice id. Must be called before using SDK
 
   @param companyId The company id which was provided to you by Ghostery
   @param pubNoticeId The pub notice id which you created on the web portal
 
 */
- (void)activateWithCompanyId:(NSString*)companyId pubNoticeId:(NSString*)pubNoticeId;


/** 
   Presents the user with a consent dialog. Depending on your pub notice id the user will be presented with either an explicit or an implied consent dialog.
 
   @param onClose The on close block to be called after the dialog is closed
   @param presentingViewController The UIViewController that the preferences screen will be presented from (if the user opens the preferences from the consent dialog)
 
 */
- (void)showConsentFlowWithOnClose:(AppNoticeSDKConsentFlowCompletionBlock)onClose presentingViewController:(UIViewController*)vc;


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
