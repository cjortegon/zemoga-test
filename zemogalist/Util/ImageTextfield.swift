//
//  ImageTextfield.swift
//  Util
//
//  Created by daniel parra on 10/31/19.
//  Copyright © 2019 Camilo Ortegon. All rights reserved.
//

import UIKit

class ImageTextfield: ToolBarTextField {
    
    public let iconSize: CGFloat = 20
    public var padding: CGFloat = 10
    public var color: UIColor?

    public var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
        
    override public func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        let iconSize = leftImage == nil ? 0 : self.iconSize
        let padding = leftImage == nil ? 8 : self.padding
        textRect.origin.x += padding
        textRect.size.width = iconSize + padding
        textRect.size.height = iconSize
        return textRect
    }
    
    fileprivate func updateView() {
        if let image = leftImage {
            leftViewMode = .always
            let view = UIView()
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSize, height: iconSize))
            imageView.image = image
            if color != nil {
                let templateImage = image.withRenderingMode(.alwaysTemplate)
                imageView.image = templateImage
                imageView.tintColor = color
            }
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            leftView = view
        } else {
            leftViewMode = .never
            leftView = nil
        }
    }
}
