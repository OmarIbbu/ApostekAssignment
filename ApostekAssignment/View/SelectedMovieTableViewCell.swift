//
//  SelectedMovieTableViewCell.swift
//  ApostekAssignment
//
//  Created by OMAR on 15/03/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit

class SelectedMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
