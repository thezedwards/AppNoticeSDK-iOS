//
//  TriangleCommon.swift
//  Triangle_swift
//
//  Created by Joe Swindler on 6/27/16.
//  Copyright © 2016 Ghostery. All rights reserved.
//

import Foundation

class TriangleCommon : NSObject {

    // singleton
    static let instance = TriangleCommon()
    
    let CrashlyticsEnabledKey = "CrashlyticsEnabled"
    
    func userDefaults() -> NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }

    func setIsCrashlyticsEnabled(value: Bool) {
        userDefaults().setBool(value, forKey: CrashlyticsEnabledKey)
        userDefaults().synchronize()
    }
    
    func isCrashlyticsEnabled() -> Bool {
        return userDefaults().boolForKey(CrashlyticsEnabledKey)
    }
}