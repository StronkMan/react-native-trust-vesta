package com.reactlibrary;
import android.app.Application;
import android.os.Handler;
import android.util.Log;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.vesta.sdk.VestaDataCollector;

public class TrustVestaModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public TrustVestaModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "TrustVesta";
  }

  @ReactMethod
  public void initializeDataCollectorService(final ReadableMap options,
                                             final Callback successCallback,
                                             final Callback errorCallback) {

    Handler mainHandler = new Handler(this.reactContext.getMainLooper());
    Runnable startDataCollector = new Runnable() {
      @Override
      public void run() {
        try {
          VestaDataCollector.start(
              (Application)reactContext.getApplicationContext(),
              options.getString("webSessionID"), options.getString("loginID"));
          successCallback.invoke(true);
        } catch (Exception e) {
          e.printStackTrace();
          errorCallback.invoke(e.getMessage());
        }
      }
    };
    mainHandler.post(startDataCollector);
  }

  @ReactMethod
  public void sendLocation(final ReadableMap location,
                           final Callback successCallback,
                           final Callback errorCallback) {
    try {
      VestaDataCollector.sendLocationData(location.getDouble("lat"),
                                          location.getDouble("long"));
      successCallback.invoke(true);
    } catch (Exception e) {
      errorCallback.invoke(e.getMessage());
    }
  }
}
