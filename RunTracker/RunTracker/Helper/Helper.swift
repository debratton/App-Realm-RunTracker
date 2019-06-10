//
//  Helper.swift
//  RunTracker
//
//  Created by David E Bratton on 6/9/19.
//  Copyright © 2019 David Bratton. All rights reserved.
//

import Foundation
import RealmSwift

class Helper {
    static let realm = try! Realm()
    
    static func saveRun(run: Run) {
        do {
            try realm.write {
                realm.add(run)
            }
        } catch {
            print("Error Saving Run: \(error.localizedDescription)")
        }
    }
    
    static func saveLocation(run: Run, location: Location) {
        do {
            try realm.write {
                run.locations.append(location)
            }
        } catch {
            print("Error Saving Item: \(error.localizedDescription)")
        }
    }
    
    static func loadRun() -> Results<Run>? {
        var runs: Results<Run>?
        runs = realm.objects(Run.self)
        let sortedRuns = runs?.sorted(byKeyPath: "date", ascending: false)
        return sortedRuns
    }
}
