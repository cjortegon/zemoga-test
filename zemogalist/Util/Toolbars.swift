//
//  Toolbars.swift
//  ios-saas
//
//  Created by Daniel Parra on 5/28/20.
//  Copyright © 2020 Camilo Ortegon. All rights reserved.
//

import UIKit

class ToolBarTextView: UITextView {
    
    init() {
        super.init(frame: CGRect.zero, textContainer: nil)
        inputAccessoryView = createToolbar(target: self, action: #selector(doneAction))
    }
    
    @objc func doneAction() {
        endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ToolBarTextField: UITextField {
    
    init() {
        super.init(frame: CGRect.zero)
        inputAccessoryView = createToolbar(target: self, action: #selector(doneAction))
    }
        
    @objc func doneAction() {
        endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate func createToolbar(target: Any, action: Selector) -> UIToolbar {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: action)
    toolbar.setItems([flexible, doneButton], animated: false)
    return toolbar
}
