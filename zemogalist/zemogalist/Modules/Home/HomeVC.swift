//
//  ViewController.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 24/01/21.
//

import UIKit

class HomeVC: UIViewController {

    var posts : [Post] = []

    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(PostCell.self, forCellReuseIdentifier: String.init(describing: PostCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    lazy var segmentedControl : UISegmentedControl = {
        let control = UISegmentedControl (items: ["all".localized(), "favorites".localized()])
        control.addTarget(self, action: #selector(switchControl), for: .allEvents)
        control.selectedSegmentIndex = 0
        return control
    }()

    lazy var emptyState = EmptyStateView()
    lazy var refreshControl = UIRefreshControl()
    lazy var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.navigationBar.barTintColor = Color.shared.green
        
        // Navigation bar
        let title = UITextView()
        title.font = UIFont.systemFont(ofSize: 18)
        title.text = "posts".localized()
        title.textColor = .white
        title.backgroundColor = .clear
        self.navigationItem.titleView = title
        
        // Refresh button
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        refreshButton.tintColor = .white
        navigationItem.rightBarButtonItem = refreshButton
        
        // Segment control
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints {
            $0.top      |=| view.s_top + (UIConstants.topMargin + (navigationController?.navigationBar.frame.height ?? 0))
            $0.centerX  |=| view.s_centerX
        }
        
        // Table view
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top      |=| segmentedControl.s_bottom + 10
            $0.bottom   |=| view.s_bottom
            $0.left     |=| view.s_left
            $0.right    |=| view.s_right
        }
        
        // Empty state
        emptyState.isHidden = true
        view.addSubview(emptyState)
        emptyState.snp.makeConstraints {
            $0.edges.equalTo(tableView)
        }
        
        // Pull to refresh
        refreshControl.addTarget(self, action: #selector(refreshTapped), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        // Indicator
        view.addSubview(indicator)
        indicator.snp.makeConstraints {
            $0.center   |=| view.center
        }
        indicator.startAnimating()
        
        onDatabaseChanged()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.onDatabaseChanged()
    }

    private func loadData() {
        // Subscribe to changes
        DatabaseReader.shared.subscribe(self)
        
        // Cached load
        self.posts = DatabaseReader.shared.getCounters()
        self.tableView.reloadData()
        
        // Remote load
        DatabaseReader.shared.load()
    }

    @objc func refreshTapped() {
        self.tableView.isHidden = true
        self.emptyState.isHidden = true
        if !self.refreshControl.isRefreshing {
            self.indicator.startAnimating()
        }
        loadData()
    }

    @objc func switchControl() {
        self.onDatabaseChanged()
    }
    
}

extension HomeVC : DatabaseSubscriber {

    func onDatabaseChanged() {
        DispatchQueue.main.async {
            self.posts = DatabaseReader.shared.getCounters(filter: nil, onlyFavorites: self.segmentedControl.selectedSegmentIndex == 1)
            self.indicator.stopAnimating()
            self.refreshControl.endRefreshing()
            self.reloadTable(emptyState: "no_messages".localized())
        }
    }

    func reloadTable(emptyState message: String) {
        self.tableView.reloadData()
        if self.posts.isEmpty {
            self.emptyState.titleLabel.text = message
            self.emptyState.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.emptyState.isHidden = true
            self.tableView.isHidden = false
        }
    }

}
