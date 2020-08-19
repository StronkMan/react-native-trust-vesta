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
                reject('not yet implemented');
            }
        });
    }
}
