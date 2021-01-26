//
//  LandingVC.swift
//  cornercounter
//
//  Created by Camilo Ortegon on 17/01/21.
//

import UIKit
import CoreData

class LandingVC: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = label.font.withSize(28)
        label.text = "welcome".localized()
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.shared.green
        label.font = label.font.withSize(28)
        label.text = "Zemoga"
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = label.font.withSize(15)
        label.numberOfLines = 0
        label.text = "test_by_camilo".localized()
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("continue".localized(), for: .normal)
        button.backgroundColor = Color.shared.blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let completedOnBoarding = LocalStorage.get("on_boarding") as? Bool ?? false
        self.navigationController?.navigationBar.isHidden = !completedOnBoarding
        
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(continueButton)
        
        titleLabel.snp.makeConstraints {
            $0.top      |=| topLayoutGuide.s_top + (completedOnBoarding ? 80 : 50)
            $0.left     |=| view.s_left + 25
        }
        nameLabel.snp.makeConstraints {
            $0.top      |=| titleLabel.s_bottom
            $0.left     |=| view.s_left + 25
        }
        subtitleLabel.snp.makeConstraints {
            $0.top      |=| nameLabel.s_bottom + 15
            $0.left     |=| view.s_left + 25
            $0.right    |=| view.s_right - 25
        }
        
        continueButton.snp.makeConstraints {
            $0.bottom   |=| bottomLayoutGuide.s_bottom - 50
            $0.centerX  |=| view.s_centerX
            $0.width    |=| view.s_width - 50
            $0.height   |=| 40
        }
    }

    @objc func continueAction() {
        self.navigationController?.pushViewController(HomeVC(), animated: true)
        LocalStorage.set("on_boarding", object: true)
    }

}
