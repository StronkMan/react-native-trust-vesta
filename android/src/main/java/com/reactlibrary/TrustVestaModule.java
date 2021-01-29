package com.reactlibrary;
import android.app.Application;
import android.os.Handler;
import android.provider.Settings;
import android.util.Log;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.threatmetrix.TrustDefender.TMXConfig;
import com.threatmetrix.TrustDefender.TMXEndNotifier;
import com.threatmetrix.TrustDefender.TMXProfiling;
import com.threatmetrix.TrustDefender.TMXProfilingHandle;
import com.threatmetrix.TrustDefender.TMXProfilingOptions;
import com.threatmetrix.TrustDefender.TMXStatusCode;
import com.vesta.sdk.VestaDataCollector;
import java.util.ArrayList;
import java.util.List;

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
              options.getString("webSessionID"), options.getString("loginID"),
              options.getBoolean("sandbox"));
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

  @ReactMethod
  public void initTM(final ReadableMap options, final Callback successCallback,
                     final Callback errorCallback) {
    String deviceId;
    /*
     * Class to get orgId and FPServer url
     */
    final TMXConfig config = new TMXConfig();
    config.setContext(reactContext.getApplicationContext());
    config.setOrgId(options.getString("orgId"));
    config.setFPServer("h.online-metrix.net");
    /*
     * Set this method to true if you are not using Location APIs in your app.
     * If you are using Location Apis then just pass the Location object in the
     * profiling section.
     */
    config.setRegisterForLocationServices(true);
    // Initialization of TrustDefender.
    try {
      TMXProfiling.getInstance().init(config);
      // Getting device id to uniquely identify the device.
      deviceId = Settings.Secure.getString(reactContext.getContentResolver(),
                                           Settings.Secure.ANDROID_ID);

      // setting device attribute in a list.
      List<String> deviceAttributesList = new ArrayList<>();
      deviceAttributesList.add(android.os.Build.BRAND);
      deviceAttributesList.add(android.os.Build.MANUFACTURER);
      deviceAttributesList.add(android.os.Build.MODEL);
      deviceAttributesList.add(deviceId);

      Log.e("Device Information", deviceAttributesList.toString());

      // Class for doing profiling process, here we are passing device attribute
      // list, WebSessionId and device current location.
      TMXProfilingOptions profilingOptions = new TMXProfilingOptions();
      profilingOptions.setSessionID(options.getString("webSessionID"));
      /*
       * If your app is using Location Apis then just pass the Location object
       * in the below method, else make this method of Config class to true
       * 'config.setRegisterForLocationServices(true)'.
       */
      // profilingOptions.setLocation(Location object);
      profilingOptions.setCustomAttributes(deviceAttributesList);

      // Managing Profiling result.

      TMXProfiling.getInstance().profile(
          profilingOptions, new TMXEndNotifier() {
            @Override
            public void complete(TMXProfilingHandle.Result result) {
              if (result != null) {
                TMXStatusCode profilingResult = result.getStatus();
                if (profilingResult == TMXStatusCode.TMX_OK) {
                  Log.e("Profiling Result", profilingResult.toString() + " " +
                                                result.getStatus().getDesc());
                  Log.e("SessionId after Profiling",
                        " " + result.getSessionID());
                  successCallback.invoke(true);
                } else {
                  errorCallback.invoke("Profiling Result",
                                       profilingResult.toString() + " " +
                                           result.getStatus().getDesc());
                }
              }
            }
          });
    } catch (Exception e) {
      e.printStackTrace();
      errorCallback.invoke(e.getMessage());
    }
  }
}
