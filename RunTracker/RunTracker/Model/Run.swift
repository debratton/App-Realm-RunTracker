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
    //@objc dynamic var id = ""
    @objc dynamic var id = UUID().uuidString.lowercased()
    @objc dynamic var date = NSDate()
    @objc dynamic var pace = 0
    @objc dynamic var distance = 0.0
    @objc dynamic var duration = 0
    let locations = List<Location>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["pace", "date", "duration"]
    }
    
    // I don't see any advantage of having this 
//    convenience init(pace: Int, distance: Double, duration: Int) {
//        self.init()
//        self.id = UUID().uuidString.lowercased()
//        self.date = NSDate()
//        self.pace = pace
//        self.distance = distance
//        self.duration = duration
//    }
    
    //I DON"T LIKE ALL THIS IN MODEL, MOVED TO Helper
//    static func saveRun(pace: Int, distance: Double, duration: Int) {
//        REALM_QUEUE.sync {
//            let run = Run(pace: pace, distance: distance, duration: duration)
//            do {
//                let realm = try Realm()
//                try realm.write {
//                    realm.add(run)
//                    try realm.commitWrite()
//                }
//            } catch {
//                debugPrint("Error Adding run \(error.localizedDescription)")
//            }
//        }
//    }
}
