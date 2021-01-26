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

}
