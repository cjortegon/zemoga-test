//
//  API.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 24/01/21.
//

import Foundation

class API {

    private static let urlBase = "https://jsonplaceholder.typicode.com"

    func getPosts(callback: @escaping ([PostCodable]?) -> Void) {
        guard let url = URL(string: "\(API.urlBase)/posts") else {
            callback(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            self.handleResponses(with: data, callback: callback)
        })
        task.resume()
    }

    func geteUsers(id: Int, callback: @escaping ([UserCodable]?) -> Void) {
        guard let url = URL(string: "\(API.urlBase)/users?id=\(id)") else {
            callback(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            self.handleResponses(with: data, callback: callback)
        })
        task.resume()
    }

    func getComments(for postId: Int, callback: @escaping ([CommentCodable]?) -> Void) {
        guard let url = URL(string: "\(API.urlBase)/comments?postId=\(postId)") else {
            callback(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            self.handleResponses(with: data, callback: callback)
        })
        task.resume()
    }

    private func handleResponses<S: Codable>(with data: Data?, callback: @escaping ([S]?) -> Void) {
        guard let data = data else {
            callback(nil)
            return
        }
        do {
            let object = try JSONDecoder().decode(ArrayResponse<S>.self, from: data)
            callback(object.items)
        } catch let err {
            print(err)
            callback(nil)
            return
        }
    }

}

private struct DummyCodable: Codable {}

struct ArrayResponse<C: Codable>: Codable {
    var items: [C]

    init(from decoder: Decoder) throws {
        var items = [C]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let item = try? container.decode(C.self) {
                items.append(item)
            } else {
                _ = try? container.decode(C.self)
            }
        }
        self.items = items
    }
}

struct PostCodable: Codable {
    var id: Int
    var userId: Int
    var title: String
    var body: String
}

struct UserCodable: Codable {
    var id: Int
    var name: String
    var email: String
    var phone: String
    var website: String
}

struct CommentCodable: Codable {
    var id: Int
    var name: String
    var email: String
    var body: String
}
