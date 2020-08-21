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
class TrustVesta: NSObject, RCTBridgeModule {
    static func moduleName() -> String! {
          return "TrustVesta";
    }
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
    @objc(initializeDataCollectorService:withCallback:)
    func initializeDataCollectorService(_ options: NSDictionary, withCallback callback:@escaping RCTResponseSenderBlock) {
        DispatchQueue.main.async {
            DataCollectorService.default.start(withSessionKey: options["webSessionID"] as! String, loginID: options["loginID"] as! String, sandboxEnabled: true) { (done)->() in
                if done {
                    callback([true]);
                }else{
                    callback([false]);
                }
            }
        }
        
    }
}
