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

## Installation

To use the AppNoticeSDK first download or clone this repository

```bash
$ git clone git@github.com:ghostery/AppNoticeSDK-iOS.git
```

To integrate AppNoticeSDK into your Xcode project:

Copy/drag `AppNoticeSDKFramework.framework` and `AppNotice.bundle` into your Xcode project:
  
![](http://i.imgur.com/5YOGvkP.png)

### Objective-C

Simply include the framework import statement wherever you want to use it

```objective-c
#import <AppNoticeSDKFramework/AppNoticeSDKFramework.h>
```
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


## Usage

### Activation

You must activate the SDK before you can use the SDK features. You do so using your Company Id and Publisher Notice Id.

##### Objective-C

```objective-c
[[AppNoticeSDK sharedInstance]activateWithCompanyId:@"242" pubNoticeId:@"6107"];
```

##### Swift

```swift
AppNoticeSDK.sharedInstance().activateWithCompanyId("242", pubNoticeId: "6107")
```

## FAQ

### What's the origin of the name Alamofire?

Alamofire is named after the [Alamo Fire flower](https://aggie-horticulture.tamu.edu/wildseed/alamofire.html), a hybrid variant of the Bluebonnet, the official state flower of Texas.

---

## Credits

Alamofire is owned and maintained by the [Alamofire Software Foundation](http://alamofire.org). You can follow them on Twitter at [@AlamofireSF](https://twitter.com/AlamofireSF) for project updates and releases.

### Security Disclosure

If you believe you have identified a security vulnerability with Alamofire, you should report it as soon as possible via email to security@alamofire.org. Please do not post it to a public issue tracker.

## License

Alamofire is released under the MIT license. See LICENSE for details.
