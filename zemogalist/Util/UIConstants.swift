//
//  UIConstants.swift
//  ios-saas
//
//  Created by Camilo Ortegon on 7/09/20.
//  Copyright © 2020 Camilo Ortegon. All rights reserved.
//

import UIKit

class UIConstants {

    static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height

    static var topMargin: CGFloat {
        if #available(iOS 12, *) {
            return 10.0 + statusBarHeight
        } else {
            return 4.0 + statusBarHeight
        }
    }

    static var bottomMargin: CGFloat {
        if #available(iOS 11.0, *) {
            return UIConstants.mainWindow?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }

    static var mainWindow: UIWindow? {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        return keyWindow
    }

}
