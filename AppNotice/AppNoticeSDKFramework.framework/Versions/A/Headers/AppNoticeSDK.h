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

typedef enum : NSUInteger {
    AppNoticeThemeLight,  // light theme
    AppNoticeThemeDark,   // dark theme
} AppNoticeTheme;

NS_ASSUME_NONNULL_BEGIN
typedef void (^AppNoticeSDKPreferencesClosedBlock)(BOOL accepted);
typedef void (^AppNoticeSDKConsentFlowCompletionBlock)(AppNoticeConsent result, NSDictionary *trackers);
typedef void (^AppNoticeSDKSessionCompletionBlock)(NSDictionary *resultsDict, NSError *error);


@interface AppNoticeSDK : NSObject

+ (instancetype)sharedInstance;

/**
 The image for the company logo you want to display in the consent dialog.
 */
@property (nonatomic, strong, nullable) UIImage *logoImage;

/** 
   Activates the SDK with your SDK token. Must be called before using SDK.
   @param token The App Notice token configured for your app.
 */
- (void)activateWithToken:(NSString*)token;

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
 @param repeatEvery30Days Causes the consent dialog to be shown every 30 days if true, or appear only once if false.
 
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

/*
 Runtime diagnostic, does not persist
 */
- (NSDictionary *)getAllTrackersDictionary;
- (NSArray *)getAllTrackersArray;

/** Optional UI customization properties. Note that the individual color properties will override the theme colors.
 */
@property (nonatomic, assign) AppNoticeTheme appTheme;
@property (nonatomic, strong, nullable) UIColor *mainTextColor;
@property (nonatomic, strong, nullable) UIColor *backgroundColor;
@property (nonatomic, strong, nullable) UIColor *acceptButtonColor;
@property (nonatomic, strong, nullable) UIColor *acceptButtonTextColor;
@property (nonatomic, strong, nullable) UIColor *declineButtonColor;
@property (nonatomic, strong, nullable) UIColor *navBarBackgroundColor;
@property (nonatomic, strong, nullable) UIColor *navBarTitleColor;
@property (nonatomic, strong, nullable) UIColor *tintColor;
@property (nonatomic, strong, nullable) UIColor *disabledColor;
@property (nonatomic, strong, nullable) UIColor *separatorColor;

/** Determines whether the web-based tab should appear in the Manage Preferences view or not.
 */
@property (nonatomic, assign) BOOL hideWebBasedTab;

/** Prints debug output to the console if enabled. Off by default.
 */
@property (nonatomic, assign) BOOL isLogEnabled;

/** 
   Resets count on consent dialog appearances and resets all tracker settings for user
 */
- (void)resetSDK;

/** GDPR Compliance Indicator.
    YES/TRUE: Enforces the GDPR app experience regardless of country.
    NO/FALSE: Allows the app to determine if the GDPR experience is required based on the
              gdprCountriesArray/Default GDPR Countries Array.
 
    To disable GDPR completely insert a place holder not matching an ISO country code in the gdprCountriesArray.
 */
@property (nonatomic, assign) BOOL gdprRequired;

/** EU-GDPR Compliance Country List.
 Primary collection that designates the countries which the GDPR compliant workflow will apply to.
 
 Adding country codes to this collection will apply the GDPR compliant workflow to users' experiences
 who are determined to be from that country.
 
 Input ISO-3166 compliant country codes only. (Example: "FR", "NL", "IT")
 https://www.iso.org/iso-3166-country-codes.html
 https://www.iso.org/obp/ui/#search/code/
 
 Ensure this array is being populated before calling the activateWithToken method.
 If this list is found to be nil, then a default list of GDPR countries will be used.
 */
@property (nonatomic, assign) NSArray *gdprCountriesArray;

@end
NS_ASSUME_NONNULL_END
