#import "TrustVesta.h"
#import "DataCollector-Swift.h"
@implementation TrustVesta

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initializeDataCollectorService
                  : (NSDictionary *)options callback
                  : (RCTResponseSenderBlock)callback) {

  NSString *webSessionID = options[@"webSessionID"];
  NSString *loginID = options[@"loginID"];
  NSString *environment = options[@"environment"];
  if ([environment isEqualToString:@"sandbox"]) {
      [DataCollectorService dc.start(withSessionKey
                                       : webSessionID, loginID
                                       : loginID, sandboxEnabled
                                       : YES) {
      (success) in if success { callback(@[ @true ]); }
    }]
  } else {
      [DataCollectorService dc.start(withSessionKey
                                       : webSessionID, loginID
                                       : loginID, sandboxEnabled
                                       : NO) {
      (success) in if success { callback(@[ @true ]); }
    }]
  }
}
@end
