//
//  Post+CoreDataClass.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 24/01/21.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject {

    var userInfo : UserCodable?

}
