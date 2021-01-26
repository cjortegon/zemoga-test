//
//  EmptyStateView.swift
//  cornercounter
//
//  Created by Camilo Ortegon on 19/01/21.
//

import UIKit

class EmptyStateView: PassThroughView {
    
    let image : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "empty_state")
        return image
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = label.font.withSize(20)
        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    func setup() {
        addSubview(image)
        addSubview(titleLabel)
        
        image.snp.makeConstraints {
            $0.center   |=| s_center
            $0.width    |=| s_width * 0.5
            $0.height   |=| s_height * 0.25
        }
        titleLabel.snp.makeConstraints {
            $0.centerX  |=| image.s_centerX
            $0.top      |=| image.s_bottom + 20
            $0.width    |=| s_width * 0.8
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class PassThroughView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
