//
//  CustomTableViewCell.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 12/20/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet var weatherLabel : UILabel!
    @IBOutlet var mountainLabel : UILabel!
    @IBOutlet var weatherRatingLabel : UILabel!
    @IBOutlet var mountainRatingLabel: UILabel!
    @IBOutlet var weatherView : UIView!
    @IBOutlet var mountainView : UIView!
    @IBOutlet var trailsOpenLabel : UILabel!
    @IBOutlet var newSnowLabel: UILabel!
    @IBOutlet var liftLabel: UILabel!
    @IBOutlet var baseDepthLabel: UILabel!
}
