//
//  PostCell.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 24/01/21.
//

import UIKit

class PostCell: UITableViewCell {

    lazy var lectureBall : UIView = {
        let view = UIView()
        view.backgroundColor = Color.shared.blue
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 3
        label.font = label.font.withSize(14)
        return label
    }()

    lazy var arrow : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_right_arrow")
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .gray
        return image
    }()

    lazy var star : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_star")
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        self.contentView.backgroundColor = .white
        
        self.addSubview(lectureBall)
        self.addSubview(contentLabel)
        self.addSubview(arrow)
        self.addSubview(star)
        
        lectureBall.snp.makeConstraints {
            $0.width    |=| 12
            $0.height   |=| 12
            $0.left     |=| s_left + 15
            $0.centerY  |=| s_centerY
        }
        star.snp.makeConstraints {
            $0.width    |=| 16
            $0.height   |=| 16
            $0.center   |=| lectureBall.s_center
        }
        arrow.snp.makeConstraints {
            $0.width    |=| s_height * 0.4
            $0.height   |=| s_height * 0.4
            $0.right    |=| s_right - 10
            $0.centerY  |=| s_centerY
        }
        contentLabel.snp.makeConstraints {
            $0.top      |=| s_top + 5
            $0.bottom   |=| s_bottom - 5
            $0.left     |=| lectureBall.s_right + 15
            $0.right    |=| arrow.s_left - 10
        }
        
    }

}
