//
//  MoviesViewController.swift
//  ApostekAssignment
//
//  Created by OMAR on 14/03/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var endPoint : String?
    var viewModel = MovieViewModel()
    static  var flag : Bool = false
    static var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        searchBar.delegate = self
        hideKeyboardWhenTappedAround()
    }
    fileprivate func callApi() {
        viewModel.getMovies(page: "1", endPoint: endPoint!, completionBlock: { (_) in
               DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
        })
    }
}
