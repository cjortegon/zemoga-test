//
//  DetailsVC.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 24/01/21.
//

import UIKit

class DetailsVC: UIViewController {

    var post : Post

    let detailsView = DetailsView()

    let favoriteImage = UIImage(named: "ic_star")
    let notFavoriteImage = UIImage(named: "ic_star_unselected")
    lazy var starButton : UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        return button
    }()

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Navigation bar
        let title = UITextView()
        title.font = UIFont.systemFont(ofSize: 18)
        title.text = "post".localized()
        title.textColor = .white
        title.backgroundColor = .clear
        self.navigationItem.titleView = title
        
        // Favorite button
        updateFavoriteButton()
        starButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: starButton)
        starButton.snp.makeConstraints {
            $0.width    |=| 25
            $0.height   |=| 25
        }
        
        // Back button
        let backButton = UIButton(type: .custom)
        backButton.setBackgroundImage(UIImage(named: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.snp.makeConstraints {
            $0.width    |=| 30
            $0.height   |=| 30
        }
        
        // Details
        view.addSubview(detailsView)
        detailsView.snp.makeConstraints {
            $0.top      |=| view.s_top + (UIConstants.topMargin + (navigationController?.navigationBar.frame.height ?? 0))
            $0.bottom   |=| view.s_bottom
            $0.left     |=| view.s_left
            $0.right    |=| view.s_right
        }
        self.loadDetails()
    }
    
    func loadDetails() {
        detailsView.descriptionLabel.text = post.body
        let api = API()
        
        // Load user
        if let user = post.userInfo {
            self.detailsView.setupUserInfo(user)
        } else {
            api.geteUsers(id: Int(post.userId)) { users in
                if let user = users?.filter({ $0.id == self.post.userId }).first {
                    self.post.userInfo = user
                    DispatchQueue.main.async {
                        self.detailsView.setupUserInfo(user)
                    }
                }
            }
        }
        
        // Load comments
        api.getComments(for: Int(post.id)) { comments in
            guard let comments = comments else { return }
            print("[Total comments: \(comments.count)]")
            DispatchQueue.main.async {
                self.detailsView.comments = comments
            }
        }
    }
    
    func updateFavoriteButton() {
        starButton.setBackgroundImage(post.favorite ? favoriteImage : notFavoriteImage, for: .normal)
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func favoriteTapped() {
        DatabaseReader.shared.toggleFavorite(post)
        updateFavoriteButton()
    }

}
