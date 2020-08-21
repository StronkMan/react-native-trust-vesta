#import <React/RCTBridgeModule.h>
@interface RCT_EXTERN_MODULE(TrustVesta, NSObject)

RCT_EXTERN_METHOD(initializeDataCollectorService:(NSDictionary *)options withCallback:(RCTResponseSenderBlock *)callback)

@end
