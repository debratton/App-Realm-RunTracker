//
//  RunCell.swift
//  RunTracker
//
//  Created by David E Bratton on 6/9/19.
//  Copyright © 2019 David Bratton. All rights reserved.
//

import UIKit

class RunCell: UITableViewCell {

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(run: Run) {
        durationLabel.text = run.duration.formatTimeDurationToString()
        distanceLabel.text = "\(run.distance.metersToMiles(places: 2)) mi"
        paceLabel.text = run.pace.formatTimeDurationToString()
        dateLabel.text = run.date.getDateString()
    }

}
