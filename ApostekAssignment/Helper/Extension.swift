//
//  Extension.swift
//  ApostekAssignment
//
//  Created by OMAR on 15/03/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import Foundation
import UIKit

extension MoviesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.getCellData(index: indexPath.row)
        let cell =  configureCell(data: data)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCell(index: indexPath.row)
    }
    
    func configureCell( data : Movie) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedMovieTableViewCell") as! SelectedMovieTableViewCell
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = UIImage(named:"rating")
        let imageOffsetY:CGFloat = -2.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let  textAfterIcon = NSMutableAttributedString(string: " " + (data.vote_average?.description ?? ""))
        completeText.append(textAfterIcon)
        cell.ratingLabel?.attributedText = completeText
        cell.titleLabel?.text = data.title
        cell.posterImage.sd_setImage(with: URL(string:  (ViewController.imageBaseurl!) + data.poster_path!), placeholderImage: UIImage(named: "default"))
        return cell
    }
    
    func selectCell(index:Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if MoviesViewController.flag == true {
            controller.viewModel = viewModel.searchedDataSourceArray[index]
        }
        
        controller.viewModel = viewModel.moviewDataSourceArray[index]
        controller.title = "Movie Detail"
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

//MARK:- Method for searchbar
extension MoviesViewController :  UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            viewModel.search(text: searchText)
            MoviesViewController.flag = true
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            /*    Can also be done using core data
             var predicate: NSPredicate = NSPredicate()
             predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
             
             */
        }else {
            MoviesViewController.flag = false
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK:- Method to hide the keyboard whne touched outside
extension MoviesViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MoviesViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK:- Method for pagination
extension MoviesViewController : UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height
        {
            MoviesViewController.pageNumber += 1
            viewModel.getMovies(page: String(MoviesViewController.pageNumber), endPoint: endPoint!, completionBlock: { (_) in
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            })
            
        }
    }
}
