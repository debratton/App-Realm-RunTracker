//
//  RunLogVC.swift
//  RunTracker
//
//  Created by David E Bratton on 6/6/19.
//  Copyright © 2019 David Bratton. All rights reserved.
//

import UIKit
import RealmSwift

class RunLogVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var runs: Results<Run>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRuns()
    }
    
    func loadRuns() {
        if let fetchedRuns = Helper.loadRun() {
            runs = fetchedRuns
            tableView.reloadData()
        }
    }
}

extension RunLogVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numRows = runs {
            return numRows.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentRun: Run
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RunCell") as? RunCell {
            currentRun = runs[indexPath.row]
            cell.configureCell(run: currentRun)
            return cell
        } else {
            return RunCell()
        }
        
    }
    
    
}
