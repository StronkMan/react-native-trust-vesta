'use strict';
import { NativeModules, Platform } from 'react-native';
import isNumber from 'lodash/isNumber'
const { TrustVesta } = NativeModules;

module.exports = {
    initDataCollector(options = {}) {
        return new Promise(function (resolve, reject) {
            if (options?.webSessionID && options?.loginID) {
                if (Platform.OS === 'ios') {
                    TrustVesta.initializeDataCollectorService(options, function (success) {
                        success ? resolve(true) : reject("Cannot init DC.");
                    });
                } else {
                    TrustVesta.initializeDataCollectorService(options, res => resolve(res), error => reject(error));
                }
            } else {
                reject("initDataCollector:: missing webSessionID or loginID");
            }
        });
    },
    sendLocation(location = { long: null, lat: null }) {
        return new Promise(function (resolve, reject) {
            if (isNumber(location?.long) && isNumber(location?.lat)) {
                if (Platform.OS === 'ios') {
                    TrustVesta.sendLocation(location, function (err, success) {
                        success ? resolve(true) : reject("Cannot send location.");
                    });
                } else {
                    TrustVesta.sendLocation(location, res => resolve(res), error => reject(error));
                }
            } else {
                reject("sendLocation:: long or lat missing or not type of Number");
            }

        });
    },
    initTM(options = {}) {
        return new Promise(function (resolve, reject) {
            if (options?.webSessionID && options?.orgId) {
                if (Platform.OS === 'ios') {
                    TrustVesta.initTM(options, function (err, success) {
                        success ? resolve(success) : reject(err);
                    });
                } else {
                    TrustVesta.initTM(options, res => resolve(res), error => reject(error));
                }
            } else {
                reject("initTM:: missing webSessionID or orgId");
            }
        });
    }
}
