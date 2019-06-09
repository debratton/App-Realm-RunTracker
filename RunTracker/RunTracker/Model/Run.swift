//
//  Run.swift
//  RunTracker
//
//  Created by David E Bratton on 6/9/19.
//  Copyright © 2019 David Bratton. All rights reserved.
//
//duration / pace / distance

import Foundation
import RealmSwift

class Run: Object {
    @objc dynamic var id = ""
    @objc dynamic var date = NSDate()
    @objc dynamic var pace = 0
    @objc dynamic var distance = 0.0
    @objc dynamic var duration = 0
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["pace", "date", "duration"]
    }
    
    convenience init(pace: Int, distance: Double, duration: Int) {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.date = NSDate()
        self.pace = pace
        self.distance = distance
        self.duration = duration
    }
}
