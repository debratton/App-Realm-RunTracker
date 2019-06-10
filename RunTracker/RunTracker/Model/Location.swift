//
//  Location.swift
//  RunTracker
//
//  Created by David E Bratton on 6/10/19.
//  Copyright © 2019 David Bratton. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
    @objc dynamic var id = UUID().uuidString.lowercased()
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    var run = LinkingObjects(fromType: Run.self, property: "locations")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
