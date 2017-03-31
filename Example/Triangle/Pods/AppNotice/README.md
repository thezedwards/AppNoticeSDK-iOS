# AppNotice SDK for iOS<br/>Installation and Customization
*Version: 2.1.5*</br>
September 2016

[![Version](https://img.shields.io/cocoapods/v/AppNotice.svg?style=flat)](http://cocoapods.org/pods/AppNotice)
[![License](https://img.shields.io/cocoapods/l/AppNotice.svg?style=flat)](http://cocoapods.org/pods/AppNotice)
[![Platform](https://img.shields.io/cocoapods/p/AppNotice.svg?style=flat)](http://cocoapods.org/pods/AppNotice)

## Features

- [x] Implied Consent Tracking
- [x] Explicit Consent Tracking
- [x] Text Customization and Localization
- [x] User Tracking Toggling

## Example

This repo comes with two example projects to demonstrate how to use the SDK. The 'Triangle' project is in Swift and Triangle-Objc is written in Objective-C. These are located in the Example folder.

To run the Triangle project, clone the repo, and run `pod install` from the Example/Triangle directory. 

## Author

Joe Swindler, Ghostery

## License

AppNotice is available under the MIT license. See the LICENSE file for more info.

## Prerequisites

- iOS 8.0+
- Xcode 7.0+
- A valid App Notice ID from the Ghostery control panel. See your Ghostery Customer Success Manager for details.

## Installation

AppNotice is available through [CocoaPods](http://cocoapods.org). To install:

Add the following line to your Podfile, then run 'pod install' and open your xcworkspace file.

```ruby
pod 'AppNotice'
```

If you are using the SDK with an Objective-C project, just add the following line to import the framework in any file that uses it. If you have a Swift project, you'll need to add this line to your bridging header file instead. (See [creating a bridging header](#bridging-header) below for how to do this.)
```Objective-C
#import <AppNoticeSDKFramework/AppNoticeSDKFramework.h>
```

### Creating a bridging header for Swift projects <a name="bridging-header"/>

If your project is in Swift and you don't already have a bridging header file, the easiest way to create it is to add a new Objective-C file to your project. Xcode will then ask if you want it to configure an Objective-C briding header. Select "Create Bridging Header", and then you can delete the extra Objective-C file you just created.

## SDK Activation <a name="activation"/>

You must activate the SDK before you can use the SDK features. You do so using your Company ID and Publisher Notice ID. 

Note that the SDK tracker list is only downloaded once and stored on the device for each publisher notice ID. This means if you make changes to the tracker list after your app is released, you'll need to create a new App Notice with a different notice ID. You will need to then update the SDK and re-publish your app before those changes will appear. 

### Swift

```swift
AppNoticeSDK.sharedInstance().activateWithCompanyId("242", pubNoticeId: "6107")
```

### Objective-C

```objective-c
[[AppNoticeSDK sharedInstance] activateWithCompanyId:@"242" pubNoticeId:@"6107"];
```

## Usage

### Asking For Consent

There are two types of consent: **Implied** and **Explicit**. Implied is the recommended (and simpler) option, but you can choose either one based on which *showConsentFlow* SDK method you call. To be fully compliant with privacy regulations, you should ask for the user's consent as early as possible after your app launches. And, if you are using explicit, the notice must appear first and prior to firing any tracking technologies.

Call the *showConsentFlow* (or *showExplicitConsentFlow*) method from the viewDidAppear method of your main view controller. This way, the SDK can determine whether the dialog needs to be shown or not.

#### Implied Consent
Implied consent is essentially a disclosure-only option. It informs the user that he is automaticaly giving consent simply by continuing to use the app, but does also accommodate turning individual trackers on/off. As such, it does not include **Accept** or **Decline** options, just **Continue**. It also includes the *repeatEvery30Days* parameter, which causes the consent dialog to be redisplayed every 30 days if true. If false, the dialog will only appear once per notice ID.

##### Swift

```swift
override func viewDidAppear(animated: Bool) {
  showPrivacyConsentFlow()
    
  super.viewDidAppear(animated)
}

func showPrivacyConsentFlow() {
  AppNoticeSDK.sharedInstance().showConsentFlowWithOnClose({ (result, trackers) in
    // TODO: Handle what you want to do based on whether the user accepted or declined consent.
    // You should also allow or block specific trackers/ads based on the 'trackers' array contents.
  }, presentingViewController:self, repeatEvery30Days:false)
}
```

##### Objective-C

```objective-c

- (void)viewDidAppear:(BOOL)animated {
  // show the privacy consent flow (if needed)
  [self showPrivacyConsentFlow];
    
  [super viewDidAppear:animated];
}

- (void)showPrivacyConsentFlow {
  [[AppNoticeSDK sharedInstance] showConsentFlowWithOnClose:^(AppNoticeConsent result, NSDictionary *trackers) {
    // TODO: Handle what you want to do based on whether the user accepted or declined consent.
    // You should also allow or block specific trackers/ads based on the 'trackers' array contents.
  } presentingViewController:self repeatEvery30Days:NO];
}
```

#### Explicit Consent
Explicit consent must either be accepted or declined by the user. If consent is accepted, your app may proceed as usual. However, if consent is declined there are a few cases that you'll need to handle:

- If your app will not function without the disclosed trackers, the customer should be prevented from using the app. Their only option is to modify their preferences or uninstall (similar to acception Terms and Conditions or not).
- If your app is fully functional without depending on any third party trackers, you can simply disable all optional trackers and let the user continue using the app.
- If your app will allow the user to continue to use the app with limited functionality, notify the user about the limitations. You might say something like: "To enjoy the full functionality of this app, you must accept the privacy preferences in the app's settings. This app will now continue with limited functionality."
- If necessary, inform the user that your app requires a restart before any newly-changed tracker settings can take effect. (Some trackers may require an app restart to be fully enabled/disabled.)
- Users have the right to withdraw consent for individual trackers at any time, even after they've already given it. The SDK's [Manage Preferences View](#preferences) should be accessible from within your app for this purpose. (This may typically be in some kind of app settings or preferences view, for example.)

##### Swift

```swift
override func viewDidAppear(animated: Bool) {
  showPrivacyConsentFlow()
    
  super.viewDidAppear(animated)
}

func showPrivacyConsentFlow() {
  AppNoticeSDK.sharedInstance().showExplicitConsentFlowWithOnClose({ (result, trackers) in
    // TODO: Handle what you want to do based on whether the user accepted or declined consent.
    // You should also allow or block specific trackers/ads based on the 'trackers' array contents.
    }, presentingViewController: self)
}
```

##### Objective-C

```objective-c

- (void)viewDidAppear:(BOOL)animated {
  // show the privacy consent flow (if needed)
  [self showPrivacyConsentFlow];
    
  [super viewDidAppear:animated];
}

- (void)showPrivacyConsentFlow {
  [[AppNoticeSDK sharedInstance] showExplicitConsentFlowWithOnClose:^(AppNoticeConsent result, NSDictionary *trackers) {
    // TODO: Handle what you want to do based on whether the user accepted or declined consent.
    // You should also allow or block specific trackers/ads based on the 'trackers' array contents.
  } presentingViewController:self];
}
```

### Tracking Preferences <a name="preferences"></a>
Users can toggle trackers on or off. To present the tracking preferences screen:

##### Swift

```swift
AppNoticeSDK.sharedInstance().showManagePreferences { () -> Void in
    // TODO: Handle what you want to do after the preferences screen is closed.
            
    // Get the newly updated tracker preferences
    if let updatedTrackers = AppNoticeSDK.sharedInstance().getTrackerPreferences() as? Dictionary<String, NSNumber> {
        // TODO: Do something with the updated trackers
    }
}
```

##### Objective-C

```objective-c
[[AppNoticeSDK sharedInstance]showManagePreferences:^{
// TODO: Handle what you want to do after the preferences screen is closed.

//Get the newly updated tracker preferences
NSDictionary *updatedTrackers = [[AppNoticeSDK sharedInstance] getTrackerPreferences];

}];
```

### Localization and Text Customization

The AppNotice SDK can support multiple languages (currently English only, but French, Italian, Dutch, German, Spanish and Portuguese will be available soon). If your app supports localization for a supported language, the AppNotice SDK will also be displayed in that langauge. To localize your app, you simply need a localization file in your project for each language you support. See [Apple's documentation](https://developer.apple.com/library/ios/documentation/MacOSX/Conceptual/BPInternational/LocalizingYourApp/LocalizingYourApp.html#//apple_ref/doc/uid/10000171i-CH5-SW2) for details on how to add localization to your app.

To customize any of the strings shown in the SDK:

1. Add a localization file to your project for the desired language (if it doesn't already exist).
2. Find the key for the string you want to customize. You'll find it in the Localizable.strings file of the SDK's `AppNotice.bundle`.
2. Copy the key into Localizable.strings file *in your own app* for the language you want to customize.
3. Set the value (not the key) of your newly added string to the text you want to display.
 
For example, to customize the `ghostery_dialog_implicit_message` property in English, copy the key from en.lproj in the SDK AppNotice bundle shown here:

![](http://i.imgur.com/Zze4J6Y.png)

Paste it into your Localizable.strings file in your project and enter the desired text as the value:
![](http://i.imgur.com/aiKt4iH.png)

If you want to apply the same change for other languages, just update the same `ghostery_dialog_implicit_message` property for the corresponding Localizable.strings file (en.lproj/Localizable.strings for English, de.lproj/Localizable.strings for German, es.lproj/Localizable.strings for Spanish, etc.).

### UI Customization

Perhaps you'd like to customize the look and feel of the AppNotice views to match the theme of your app. If all you need to do is change from the default light theme to a dark theme, simply set the appTheme property on AppNoticeSDK:

```swift
AppNoticeSDK.sharedInstance().appTheme = AppNoticeThemeDark
```

```objective-c
[AppNoticeSDK sharedInstance].appTheme = AppNoticeThemeDark;
```

For more detailed customization, the following AppNoticeSDK UIColor properties are available:
- *mainTextColor*: Color of the text within the SDK.
- *backgroundColor*: Background color of all views.
- *acceptButtonColor*: Tint/background color of the Accept/Continue buttons.
- *acceptButtonTextColor*: Text color of the Accept/Continue buttons.
- *declineButtonColor*: Color of the Decline buttons.
- *navBarBackgroundColor*: Background color of the navigation bar.
- *navBarTitleColor*: Color of the center title text of the navigation bar.
- *tintColor*: The tint color applies to the checkboxes, the Settings button, and the back/forward buttons in the navigation bar.
- *disabledColor*: The color of the disabled checkbox state (used in the essential tab).
- *separatorColor*: The color for horizontal and vertical separators as well as the selected color of the preferences table view cells.

### Supporting Multiple App Versions

To support multiple versions of your app that each have a different set of trackers, use a unique App Notice configuration in each version of your app. Use the Ghostery control panel (https://my.ghosteryenterprise.com) to create an App Notice configuration for each version of your app that has a different combination of trackers.

After creating an App Notice, make sure to use the correct App Notice ID in your app when you initialize the SDK as [shown above](#activation).
