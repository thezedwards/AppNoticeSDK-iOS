//
//  ViewController.swift
//  Triangle_swift
//
//  Created by Mark Price on 9/24/15.
//  Copyright © 2015 Ghostery. All rights reserved.
//

import UIKit

let ADMOB_ID = "464"

class ViewController: UIViewController {

    @IBOutlet weak var bannerView: GADBannerView!
    
    var trackers: Dictionary<String, NSNumber>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(animated: Bool) {
        showPrivacyConsentFlow();
    }
    
    func showPrivacyConsentFlow() {
        AppNoticeSDK.sharedInstance().showConsentFlowWithOnClose({ (consentAccepted, consentSkipped, trackers) -> Void in
            
            // Handle what you want to do based on the user's consent choice.
            if consentAccepted {
                // Decide which trackers/ads to use/show based on the trackersArray preferences.
                // Each tracker has an id and a status. The id is the unique id for that tracker, and the status is a boolean value.
                print("Trackers: \(trackers.debugDescription)")
                
                if let trackers = trackers as? Dictionary<String, NSNumber> {
                    self.trackers = trackers
                }
                
                self.toggleTrackers()
            }
            else {
                // Consent was declined
                let alertController = UIAlertController(title: "Consent Declined",
                    message: "This app can not be used without giving consent.",
                    preferredStyle: .Alert)
                
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                    self.showPrivacyConsentFlow()
                })
                alertController.addAction(okAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                return;
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
}

