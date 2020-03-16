//
//  MovieCollectionViewCell.swift
//  ApostekAssignment
//
//  Created by OMAR on 14/03/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        posterImage.layer.cornerRadius = 6
    }
}
