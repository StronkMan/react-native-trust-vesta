//
//  LemonBankProfileController.swift
//  VestaCorporation
//
//  Created by Admin on 05/03/2018.
//  Copyright © 2018 VestaCorporation. All rights reserved.
//

import Foundation
import TMXProfiling

class TrustDefender: NSObject {
    static let shared = TrustDefender()
    
    private var profile: TMXProfiling = TMXProfiling.sharedInstance()!
    
    private var sessionID: String = ""
    private var orgID: String = ""
    private var webSessionID: String = ""
    private var deviceName : String = ""
    private var deviceModel : String = ""
    
    func configure(forDeviceName name: String, deviceModel: String, orgID: String, webSessionID: String) {
        self.deviceName = name
        self.deviceModel = deviceModel
        self.orgID = orgID
        self.webSessionID = webSessionID
        
        //Configuration only fails due to programming error, therefore by using an assert here we make sure there is no error in our configuration object
        profile.configure(configData: [
            TMXOrgID: orgID,
            TMXFingerprintServer: "h.online-metrix.net",
            // (OPTIONAL) If Keychain Access sharing groups are used, specify like this
            TMXKeychainAccessGroup: "TEAMID.com.threatmetrix",
            // (OPTIONAL) Register for location service updates
            // Note that this call can prompt the user for permissions. The related call
            // registerLocationServices will only activate location services have already been
            // granted. But in this case, we want the request to happen
            TMXLocationServices: true,
        ])
    }
    
    
    func doProfile()-> String {
        // (OPTIONAL) Retrieve the version of the mobile SDK
        NSLog("Using TrustDefender framework \(profile.version())")
        var res = ""
        // Fire off the profiling request.
        profile.profileDevice(profileOptions: [TMXCustomAttributes: [deviceName, deviceModel], TMXSessionID: webSessionID]) { (result) in
            guard let response = result as? [String: Any],
                let sessionID = response[TMXSessionID] as? String,
                let profileStatus = response[TMXProfileStatus] as? NSNumber,
                let status = TMXStatusCode(rawValue: profileStatus.intValue) else {
                res = "THMTrustDefender profile wrong response"
                return
            }
            
            var statusString = ""
            self.sessionID = sessionID
            switch status {
                case .ok: statusString = "ok"
                case .networkTimeoutError: statusString = "Timed out"
                case .connectionError: statusString = "Connection Error"
                case .hostNotFoundError: statusString = "Host Not Found Error"
                case .internalError: statusString = "Internal Error"
                case .interruptedError: statusString = "Interrupted Error"
                default: statusString = "Other reason"
            }
            
            res = "Profile completed with: \(statusString) and session ID: \(self.sessionID)"
        }
        return res;
    }
}
