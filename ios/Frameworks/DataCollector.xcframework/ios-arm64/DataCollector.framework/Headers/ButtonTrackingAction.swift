//
//  ButtonTrackingAction.swift
//  DataCollector
//
//  Created by Herzon Rodriguez on 6/10/20.
//  Copyright © 2020 Vesta Corporation. All rights reserved.
//

import Foundation

public enum ButtonTrackingAction: String {
    case LoginAttempt = "LoginAttempt"
    case ForgotPassword = "ForgotPassword"
    case SignUp = "SignUp"
    case SignUpAttempt = "SignUpAttempt"
    case Search = "Search"
    case AddToCart = "AddToCart"
    case RemoveFromCart = "RemoveFromCart"
    case ShowCart = "ShowCart"
    case ProceedToCheckout = "ProceedToCheckout"
    case ConfirmPaymentMethod = "ConfirmPaymentMethod"
    case ConfirmShippingMethod = "ConfirmShippingMethod"
    case CompleteOrder = "ComlpeteOrder"
}
