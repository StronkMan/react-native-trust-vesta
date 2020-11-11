# react-native-trust-vesta

## Getting started

`$ npm install react-native-trust-vesta --save`

### Mostly automatic installation

`$ react-native link react-native-trust-vesta`

## Usage
```javascript
import TrustVesta from 'react-native-trust-vesta';


TrustVesta.initDataCollector(options:{webSessionID:string, loginID:string});
TrustVesta.initTM(options:{webSessionID: string, orgId: string})
TrustVesta.sendLocation(options:{long: number, lat: number});
```
