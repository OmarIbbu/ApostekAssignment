//
//  MovieTableViewCell.swift
//  ApostekAssignment
//
//  Created by OMAR on 14/03/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var viewModel = MovieViewModel()
    var popularMovies = [Movie]()
    var topRelatedMovies = [Movie]()
    var discoverMovies = [Movie]()
    @IBOutlet weak var collectionView: UICollectionView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        callApi()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func callApi() {
        getPopularMovies()
        getDiscoverMovies()
        getTopRelatedMovies()
    }
    
    func getPopularMovies() {
        viewModel.getParticularMovies(endPoint: ViewController.popularEndPoint! + "1") { (result) in
                self.popularMovies = result
               self.collectionView.reloadData()
    }
  }
 
      func getTopRelatedMovies() {
        viewModel.getParticularMovies(endPoint: ViewController.topRelatedEndPoint! + "1") { (result) in
                  self.topRelatedMovies = result
                  self.collectionView.reloadData()
      }
    }
    
      func getDiscoverMovies() {
        viewModel.getParticularMovies(endPoint:ViewController.discoverEndPoint! + "1") { (result) in
            self.discoverMovies = result
            self.collectionView.reloadData()
      }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return popularMovies.count
        case 1:
            return topRelatedMovies.count
        case 2:
            return discoverMovies.count
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        switch collectionView.tag {
        case 0:
            cell.posterImage.sd_setImage(with: URL(string: ViewController.imageBaseurl! + (popularMovies[indexPath.row].poster_path ?? "")), placeholderImage: UIImage(named: "default"))
        case 1:
            cell.posterImage.sd_setImage(with: URL(string: ViewController.imageBaseurl! + (topRelatedMovies[indexPath.row].poster_path ?? "")), placeholderImage: UIImage(named: "default"))
        case 2:
            cell.posterImage.sd_setImage(with: URL(string: ViewController.imageBaseurl! + (discoverMovies[indexPath.row].poster_path ?? "")), placeholderImage: UIImage(named: "default"))
        default:
            break
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: 100, height: 150)
        return size
    }
}
