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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
