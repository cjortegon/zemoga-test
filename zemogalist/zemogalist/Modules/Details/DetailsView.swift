//
//  DetailsView.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 24/01/21.
//

import UIKit

class DetailsView: UIView {

    var comments: [CommentCodable] = [] {
        didSet {
            self.tableOfComments.reloadData()
            self.wrapContent()
        }
    }
    let commentCellHeight : CGFloat = 60

    let scrollView = UIScrollView()

    lazy var descriptionTitle : UILabel = {
        let label = UILabel()
        label.text = "description".localized()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    lazy var userTitle : UILabel = {
        let label = UILabel()
        label.text = "user".localized()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    lazy var commentsTitle : UILabel = {
        let label = UILabel()
        label.text = "comments".localized().uppercased()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    lazy var userDetailsLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()

    lazy var tableContainer = UIView()
    lazy var tableOfComments : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CommentCell.self, forCellReuseIdentifier: String.init(describing: CommentCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        let content = UIView()
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.addSubview(content)
        content.snp.makeConstraints {
            $0.top      |=| scrollView.s_top
            $0.width    |=| s_width
        }
        
        content.addSubview(descriptionTitle)
        content.addSubview(descriptionLabel)
        content.addSubview(userTitle)
        content.addSubview(userDetailsLabel)
        
        descriptionTitle.snp.makeConstraints {
            $0.left     |=| content.s_left + 10
            $0.top      |=| content.s_top + 10
        }
        descriptionLabel.snp.makeConstraints {
            $0.centerX  |=| content.s_centerX
            $0.top      |=| descriptionTitle.s_bottom + 7
            $0.width    |=| content.s_width - 20
        }
        userTitle.snp.makeConstraints {
            $0.left     |=| content.s_left + 10
            $0.top      |=| descriptionLabel.s_bottom + 10
        }
        userDetailsLabel.snp.makeConstraints {
            $0.centerX  |=| content.s_centerX
            $0.top      |=| userTitle.s_bottom + 7
            $0.width    |=| content.s_width - 20
        }
        
        let commentsTitleContainer = UIView()
        commentsTitleContainer.backgroundColor = Color.shared.grayBackground
        content.addSubview(commentsTitleContainer)
        commentsTitleContainer.snp.makeConstraints {
            $0.top      |=| userDetailsLabel.s_bottom + 10
            $0.left     |=| content.s_left
            $0.width    |=| content.s_width
            $0.height   |=| 30
        }
        commentsTitleContainer.addSubview(commentsTitle)
        commentsTitle.snp.makeConstraints {
            $0.left     |=| commentsTitleContainer.s_left + 10
            $0.centerY  |=| commentsTitleContainer.s_centerY
        }
        
        content.addSubview(tableContainer)
        tableContainer.snp.makeConstraints {
            $0.top      |=| commentsTitleContainer.s_bottom
            $0.left     |=| content.s_left
            $0.width    |=| content.s_width
            $0.bottom   |=| scrollView.s_bottom
        }
        tableOfComments.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: commentCellHeight))
        tableContainer.addSubview(tableOfComments)
    }

    func setupUserInfo(_ user: UserCodable) {
        self.userDetailsLabel.text = """
            \("name".localized()): \(user.name)
            \("email".localized()): \(user.email)
            \("phone".localized()): \(user.phone)
            \("website".localized()): \(user.website)
            """
        wrapContent()
    }

    func wrapContent() {
        let tableSize = CGSize(width: UIScreen.main.bounds.width, height: commentCellHeight * CGFloat(comments.count+1))
        tableOfComments.frame.size = tableSize
        scrollView.wrapContent()
    }

}
