'use strict';
import { NativeModules, Platform } from 'react-native';
const { TrustVesta } = NativeModules;

module.exports = {
    initDataCollector(options = {}) {
        return new Promise(function (resolve, reject) {
            if (Platform.OS === 'ios') {
                TrustVesta.initializeDataCollectorService(options, function (success) {
                    success ? resolve(true) : reject("Cannot init.");
                });
            } else {
                TrustVesta.initializeDataCollectorService(options, res => resolve(res), error => reject(error));
            }
        });
    },
    sendLocation(location = { long: null, lat: null }) {
        return new Promise(function (resolve, reject) {
            if (Platform.OS === 'ios') {
                TrustVesta.sendLocation(location, function (success) {
                    success ? resolve(true) : reject("Cannot send location.");
                });
            } else {
                TrustVesta.sendLocation(location, res => resolve(res), error => reject(error));
            }
        });
    }
}
