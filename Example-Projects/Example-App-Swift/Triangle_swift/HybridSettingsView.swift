//
//  HybridSettingsViewController.swift
//  Triangle_swift
//
//  Created by Joe Swindler on 3/7/16.
//  Copyright © 2016 Ghostery. All rights reserved.
//

import UIKit

class HybridSettingsViewController: UIViewController {

    @IBAction func inAppPrivacyButtonPressed(sender: AnyObject) {
        AppNoticeSDK.sharedInstance().showManagePreferences({ () -> Void in
            //Handle what you want to do after the preferences screen is closed
            //if let trackers = AppNoticeSDK.sharedInstance().getTrackerPreferences() as? Dictionary<String, NSNumber> {
                // update the trackers list within the app if any settings were changed
            //}
            }, presentingViewController: self)        
    }
    
}
