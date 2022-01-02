    //
//  PlaceTableViewCell.swift
//  GradientTableView
//
//  Created by mit on 9/23/21.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let identifier = "PlaceTableViewCell"
    
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var tileLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func setIcon(place: PlaceType) {
        let mask = IconView(frame: frame, place: place)
        self.mask = mask.createMask()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}


