//
//  FieldTags.swift
//  DataCollector
//
//  Created by Herzon Rodriguez on 5/14/20.
//  Copyright © 2020 Vesta Corporation. All rights reserved.
//

import Foundation

public enum FieldTags: String {
    case LoginID = "LoginID"
    case Password = "Password"
    case ProductSearch = "ProductSearch"
    case AddToCart = "AddToCart"
    case RemoveFromCart = "RemoveFromCart"
    case TransferRecipient = "TransferRecipient"
    case TransferSender = "TransferSender"
    case TransferToAccount = "TransferToAccount"
    case TransferAmount = "TransferAmount"
    case TransferDate = "TransferDate"
    case BillingFirstName = "BillingFirstName"
    case BillingLastName = "BillingLastName"
    case BillingAddressLine1 = "BillingAddressLine1"
    case BillingAddressLine2 = "BillingAddressLine2"
    case BillingCity = "BillingCity"
    case BillingRegion = "BillingRegion"
    case BillingPostalCode = "BillingPostalCode"
    case BillingCountryCode = "BillingCountryCode"
    case PurchaseCardNumber = "PurchaseCardNumber"
    case PurchaseCardExpirationDateFull = "PurchaseCardExpirationDateFull"
    case PurchaseCardExpirationDateMonth = "PurchaseCardExpirationDateMonth"
    case PurchaseCardExpirationDateYear = "PurchaseCardExpirationDateYear"
    case PurchaseCardCVV = "PurchaseCardCVV"
    case PurchaseAlternateAccount = "PurchaseAlternateAccount"
    case DeliveryRecipient = "DeliveryRecipient"
    case DeliveryMethod = "DeliveryMethod"
}
