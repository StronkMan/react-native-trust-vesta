package com.reactlibrary;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;
import com.vesta.sdk.VestaDataCollector;


import java.util.Objects;

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
    public void initializeDataCollectorService(final ReadableMap options, final Callback successCallback,
                                               final Callback errorCallback) {
        try{
            VestaDataCollector.start(getCurrentActivity().getApplication(), options.getString("webSessionID"), options.getString("loginID"), options.getString("environment").equals("sandbox"));
            successCallback.invoke(true);
        }catch(Exception e){
            errorCallback.invoke(e.getMessage());
        }

    }

    @ReactMethod
    public void sendLocation(final ReadableMap location, final Callback successCallback,
                                               final Callback errorCallback) {
        try {
            VestaDataCollector.sendLocationData(location.getDouble("lat"), location.getDouble("long"));
            successCallback.invoke(true);
        }catch(Exception e){
            errorCallback.invoke(e.getMessage());
        }
    }
}
