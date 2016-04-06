//
//  ViewController.swift
//  Triangle_swift
//
//  Created by Mark Price on 9/24/15.
//  Copyright © 2015 Ghostery. All rights reserved.
//

import UIKit

let ADMOB_ID = "464"

class ViewController: UIViewController, AppNoticeSDKProtocol {

    @IBOutlet weak var bannerView: GADBannerView!
    var isShowingConsentDialog = false
    
    var trackers: Dictionary<String, NSNumber>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the app notice delegate if you need to show a custom view when the
        // Manage Preferences button is pressed.s
        AppNoticeSDK.sharedInstance().delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: #selector(showPrivacyConsentFlow),
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        // show the privacy consent flow if needed
        showPrivacyConsentFlow()
        
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
        
        super.viewDidDisappear(animated)
    }
    
    func showPrivacyConsentFlow() {
        AppNoticeSDK.sharedInstance().showConsentFlowWithOnClose({ (result, trackers) -> Void in
            
            // Handle what you want to do based on the user's consent choice.
            if result == AppNoticeConsentAccepted {
                // Decide which trackers/ads to use/show based on the trackersArray preferences.
                // Each tracker has an id and a status. The id is the unique id for that tracker, and the status is a boolean value.
                print("Trackers: \(trackers.debugDescription)")
                
                if let trackers = trackers as? Dictionary<String, NSNumber> {
                    self.trackers = trackers
                }
                
                self.toggleTrackers()
            }
            else if result == AppNoticeConsentDeclined {
                // Consent was declined
                let alertController = UIAlertController(title: "Consent Declined",
                    message: "To enjoy the full functionality of this app, you must accept the privacy preferences. To do so, either open preferences or restart the app. The app will now continue with limited functionality.",
                    preferredStyle: .Alert)
                
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                    // Limit app functionality here
                })
                alertController.addAction(okAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }

        }, presentingViewController: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openPrefs(sender: AnyObject) {
        
        AppNoticeSDK.sharedInstance().showManagePreferences({ () -> Void in
            //Handle what you want to do after the preferences screen is closed
            
            //Get the newly updated tracker preferences
            if let trackers = AppNoticeSDK.sharedInstance().getTrackerPreferences() as? Dictionary<String, NSNumber> {
                self.trackers = trackers
                self.toggleTrackers()
            }
            }, presentingViewController: self)
    }
    
    //You will want to toggle all of your trackers in a similar manner based on the user's tracker preferences. Ensure that the trackers are not working behind the scenes
    //even if you have hidden the UI. You don't want any communications from and to the trackers if toggled off
    func toggleTrackers() {
        
        if let adMobStatus = self.trackers[ADMOB_ID] {
            
            // The trackers dictionary is formatted like this: "464": 1
            // Where "464" is a String key representing the unique Ghostery Ad Id and where 1 is an NSNumber Boolean value - 0 is off and 1 is on
            if (adMobStatus.boolValue) {
                bannerView.hidden = false
                bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
                bannerView.rootViewController = self
                
                let request = GADRequest()
                request.testDevices = ["2077ef9a63d2b398840261c8221a0c9a"]
                bannerView.loadRequest(request)
            } else {
                //Turn off tracker
                bannerView.adUnitID = nil
                bannerView.rootViewController = nil
                bannerView.hidden = true
            }
        }
    }

    @IBAction func resetSdkButtonPressed(sender: AnyObject) {
        AppNoticeSDK.sharedInstance().resetSDK()
        let alertView = UIAlertView.init(title: "Reset SDK", message: "The App Notice SDK has been reset.", delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
    

    // MARK: - AppNoticeSDKProtocol
    
    func managePreferencesButtonPressed() -> Bool {
        // Show your custom view and return true, or return false and do nothing.
        if let controller = storyboard?.instantiateViewControllerWithIdentifier("HybridSettingsView") {
            navigationController?.pushViewController(controller, animated: true)
        }
        
        return true
    }

}

