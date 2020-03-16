//
//  DetailViewController.swift
//  ApostekAssignment
//
//  Created by OMAR on 14/03/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    //MARK:- Properties
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var viewModel: Movie? {
        didSet{
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    
    //MARK: A method to assign the instance of Movie class to labels of the view
    func updateView(){
        guard let movie = viewModel else {return}
        guard isViewLoaded else {return}
        
        let relaseDate = "Release Date " + ":"  + "  " + (movie.release_date ?? "")
        let rating = "Rating " + ":" + "  " + (movie.vote_average?.description ?? "")
        titleLabel.text = movie.title
        aboutLabel.text = movie.overview
        ratingLabel.attributedText =  rating.withBoldText(text: "Rating")
        releaseDateLabel.attributedText = relaseDate.withBoldText(text: "Release Date")
        posterImage.sd_setImage(with: URL(string:  ViewController.imageBaseurl! + movie.poster_path!), placeholderImage: UIImage(named: "default"))
        
    }
}
