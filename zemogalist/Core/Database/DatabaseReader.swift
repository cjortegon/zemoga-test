//
//  DatabaseReader.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 24/01/21.
//

import UIKit
import CoreData

class DatabaseReader {

    static let shared = DatabaseReader()

    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let api = API()

    private var items : [Post] = []
    private var subscriptions : [DatabaseSubscriber] = []
    
    private func readCurrent() {
        if items.count == 0 {
            do {
                self.items = try self.context.fetch(Post.fetchRequest())
                self.items = items.sorted(by: { (p1, p2) in p1.id < p2.id })
            } catch {}
        }
    }

    func getCounters(filter: String? = nil, onlyFavorites : Bool = false) -> [Post] {
        let words : [String] = filter?.lowercased().split(separator: " ").map({ String($0) }) ?? []
        readCurrent()
        if onlyFavorites {
            return items.filter({ $0.favorite })
        } else {
            return items
        }
    }

    func load() {
        self.readCurrent()
        var newCounter = 20
        self.api.getPosts() { posts in
            posts?.filter({ p in
                return !self.items.contains(where: { $0.id == p.id })
            }).forEach({ post in
                let newpost = Post(context: DatabaseReader.shared.context)
                newpost.unread = newCounter > 0
                newCounter -= 1
                newpost.id = Int64(post.id)
                newpost.userId = Int64(post.userId)
                newpost.title = post.title
                newpost.body = post.body
                self.items.append(newpost)
            })
            self.saveContext()
            self.callSubscriptors()
        }
    }

    func delete(_ item: Post) {
        self.items = self.items.filter({ $0 != item })
        self.context.delete(item)
    }
    func markAsRead(_ post: Post) {
        post.unread = false
        self.saveContext()
    }
    func toggleFavorite(_ post: Post) {
        post.favorite = !post.favorite
        self.saveContext()
    }

    private func saveContext() {
        do {
            try self.context.save()
        } catch {}
    }

    func subscribe(_ subscriber: DatabaseSubscriber) {
        self.subscriptions.append(subscriber)
    }

    private func callSubscriptors() {
        print("[Total posts: \(self.items.count)]")
        self.subscriptions.forEach { $0.onDatabaseChanged() }
    }

}

protocol DatabaseSubscriber {
    func onDatabaseChanged()
}
