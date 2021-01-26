//
//  MLocalStorage.swift
//  ios-saas
//
//  Created by daniel parra on 3/12/19.
//  Copyright © 2019 Camilo Ortegon. All rights reserved.
//

import Foundation

class LocalStorage {

    class func get(_ key: String) -> Any? {
        let value = UserDefaults.standard.object(forKey: key)
        return value
    }

    class func set(_ key: String, object: Any?) {
        defer {
            UserDefaults.standard.synchronize()
        }
        if let _object = object {
            UserDefaults.standard.set(_object, forKey: key)
            return
        }
        UserDefaults.standard.removeObject(forKey: key)
    }

    class func safeSetString(_ key: String, object: String?) {
        defer {
            UserDefaults.standard.synchronize()
        }
        
        if object != get(key) as? String {
            UserDefaults.standard.set(object, forKey: key)
            return
        }
    }

}
