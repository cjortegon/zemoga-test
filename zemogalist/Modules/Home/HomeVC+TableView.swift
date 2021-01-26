//
//  HomeVC+TableView.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 24/01/21.
//

import UIKit

extension HomeVC : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.posts[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: PostCell.self)) as? PostCell else { return UITableViewCell() }
        
        // Content label
        let textRange = NSMakeRange(0, item.title?.count ?? 1)
        let attributedText = NSMutableAttributedString(string: "\(item.title ?? "") \(item.body ?? "").")
        
        // Bold for title
        attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: cell.contentLabel.font.pointSize), range: textRange)
        cell.contentLabel.attributedText = attributedText
        
        // Unread & favorite
        cell.star.isHidden = !item.favorite
        cell.lectureBall.isHidden = !item.unread
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteItem(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction =  UIContextualAction(style: .destructive, title: "", handler: { (_,_,_ ) in
            self.deleteItem(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        deleteAction.image = UIImage(named: "ic_delete")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    private func deleteItem(at indexPath: IndexPath) {
        let item = self.posts[indexPath.row]
        self.posts = self.posts.filter({ $0 != item })
        DatabaseReader.shared.delete(item)
    }

}

extension HomeVC : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.posts[indexPath.row]
        DatabaseReader.shared.markAsRead(post)
        self.navigationController?.pushViewController(DetailsVC(post: post), animated: true)
    }

}
