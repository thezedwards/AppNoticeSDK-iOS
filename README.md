<div style="text-align:center;margin-left:15px"><img src="http://i.imgur.com/yDr7WeL.png" /></div>


# AppNoticeSDK-iOS
Ghostery AppNoticeSDK

## Features

- [x] Implied Consent Tracking
- [x] Explicit Consent Tracking
- [x] Customize SDK Colors
- [x] Remote and Offline Support
- [x] User Tracking Toggling
- [x] iOS 9 Support

## Requirements

- iOS 8.0+
- Xcode 7.0+

##Example Projects

This repo comes with two example projects to demonstrate how to use the SDK. One project is in Swift and the other in Objective-C.

## Installation

To use the AppNoticeSDK first download or clone this repository:

```bash
$ git clone git@github.com:ghostery/AppNoticeSDK-iOS.git
```

To integrate AppNoticeSDK into your Xcode project:

Copy/drag `AppNoticeSDKFramework.framework` and `AppNotice.bundle` into your Xcode project:
  
![](http://i.imgur.com/5YOGvkP.png)

### Swift

  1.  Creating a bridging header file:
  <br>
![](http://i.imgur.com/WOWD1gH.png)

  2.  Include the Objective-C import inside that bridging header:

```objective-c
//  Triangle_swift-Bridging-Header.h
//  Triangle_swift
//
//  Created by Mark Price on 9/24/15.
//  Copyright © 2015 Ghostery. All rights reserved.
//

#import <AppNoticeSDKFramework/AppNoticeSDKFramework.h>
```

### Objective-C

Simply include the framework import statement wherever you want to use it

```objective-c
#import <AppNoticeSDKFramework/AppNoticeSDKFramework.h>
```

## Usage

### Activation

You must activate the SDK before you can use the SDK features. You do so using your Company Id and Publisher Notice Id.

##### Swift

```swift
AppNoticeSDK.sharedInstance().activateWithCompanyId("242", pubNoticeId: "6107")
```

##### Objective-C

```objective-c
[[AppNoticeSDK sharedInstance] activateWithCompanyId:@"242" pubNoticeId:@"6107"];
```

### Asking For Consent

There are two types of consent, **Implied** and **Explicit**. Implied consent is a read-only option that does not have **Accept** or **Decline** options. Explicit consent must be accepted or declined. If declined, the user should not be permitted to use your app features until consent has been given. You should show this dialog as early as possible after your application launches.

Implied or Explicit is determined by your Publisher Notice Id. You make one call to present the consent dialog:

##### Swift

```swift
AppNoticeSDK.sharedInstance().showConsentFlowWithOnClose { (consentAccepted, consentSkipped, trackers) -> Void in
    // TODO: Handle what you want to do based on whether the user accepted or declined consent.
    // This is also where you can decide which trackers/ads to use/show based on the trackersArray preferences.
            
    // The trackers available to your application. Each tracker has an id and a status.
    // The id is the unique id for that tracker, and the status is a boolean value (true or false).            
    print("Trackers: \(trackers.debugDescription)")

}
```

##### Objective-C

```objective-c
[[AppNoticeSDK sharedInstance] showConsentFlowWithOnClose:^(BOOL consentAccepted, BOOL consentSkipped, NSDictionary *trackers) {
// TODO: Handle what you want to do based on whether the user accepted or declined consent.
// This is also where you can decide which trackers/ads to use/show based on the trackersArray preferences.

// The trackers available to your application. Each tracker has an id and a status.
// The id is the unique id for that tracker, and the status is a boolean value (YES or NO).
NSLog(@"Trackers: %@",[trackers debugDescription]);

}];
```

### Tracking Preferences
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

### Customization of UI and Consent Messages

In the `AppNotice.bundle` there is a `Configuration.plist` file. This file allows you to customize UI properties and the text shown when your application asks the user for consent:

![](http://i.imgur.com/GHQamgR.png)

By default this `Configuration.plist` file will not be used and the SDK will instead grab settings from the server (remote).

#### Use Remote Values

To use your local file you need to set `useRemoteValues` to `false`:

##### Swift

```swift
AppNoticeSDK.sharedInstance().useRemoteValues = false
```

##### Objective-C

```objective-c
[AppNoticeSDK sharedInstance].useRemoteValues = NO;
```

### Localization

The AppNotice SDK supports multiple languages (currently English, French, Italian, Dutch, German, and Spanish). If your app supports localization for a supported language, the AppNotice SDK will also be displayed in that langauge. To localize your app, you simply need a localization file in your project for each language you support.

To customize any of the strings shown in the SDK, simply open the localization file in the `AppNotice.bundle` for the language you want to customize and change the value (not the key). For example, this screenshot highlights the English text to change for the `ghostery_dialog_explicit_message` key:

![](http://i.imgur.com/09ZRYXx.png)
