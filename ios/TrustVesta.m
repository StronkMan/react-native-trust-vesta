#import "TrustVesta.h"
#import "DataCollector-Swift.h"
    @implementation TrustVesta

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initializeDataCollectorService
                  : (NSDictionary *)options callback
                  : (RCTResponseSenderBlock)callback) {

  NSString *webSessionID = options[@"webSessionID"];
  NSString *loginID = options[@"loginID"];
  bool *sandboxEnabled = options[@"sandbox"];
  DataCollectorService.default.start(withSessionKey
                                     : webSessionID, loginID
                                     : loginID, sandboxEnabled
                                     : sandboxEnabled) {
    (success) in if success {
      callback(@[ @true ]);
    }
  }

  @end
