//
//  DetailsView+TableView.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 25/01/21.
//

import UIKit

extension DetailsView : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.comments[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: CommentCell.self)) as? CommentCell else { return UITableViewCell() }
        cell.commentLabel.text = item.body
        return cell
    }

}

extension DetailsView : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return commentCellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

}

class CommentCell: UITableViewCell {

    lazy var commentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        contentView.backgroundColor = .white
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints {
            $0.center   |=| contentView.center
            $0.width    |=| s_width - 20
            $0.height   |=| s_height - 10
        }
    }

}
