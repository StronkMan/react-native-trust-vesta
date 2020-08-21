//
//  TrustVesta.swift
//  TrustVesta
//
//  Created by Kenneth on 8/21/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import DataCollector
import Foundation

@objc(TrustVesta)
class TrustVesta: NSObject {
    @objc(initializeDataCollectorService:callback:)
    func initializeDataCollectorService(_ options: NSDictionary, callback:@escaping RCTResponseSenderBlock) {
        DataCollectorService.default.start(withSessionKey: options["webSessionID"] as! String, loginID: options["loginID"] as! String, sandboxEnabled: true) { success in
            if success {
                callback([NSNull(), true]);
            }else{
                callback([NSNull(), false]);
            }
        }
    }
}
