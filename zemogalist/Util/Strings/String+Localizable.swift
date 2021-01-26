//
//  String+Localizable.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 24/01/21.
//

import Foundation

extension String {

    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }

}
