//
//  ViewModel.swift
//  ApostekAssignment
//
//  Created by OMAR on 14/03/20.
//  Copyright © 2020 OMAR. All rights reserved.

import Foundation

class MovieViewModel{
    typealias completionBlock = ([Movie]) -> ()
    var movieArray = [Movie]()
    var moviewDataSourceArray = [Movie]()
    var searchedDataSourceArray = [Movie]()
    
    func getMovies(page:String,endPoint:String,completionBlock : @escaping completionBlock){
        let service = Service(baseUrl: ViewController.baseUrl!)
        service.getMovie(endPoint: endPoint  + page)
        service.completionHandler { [weak self] (movie, status, message) in
            if status {
                guard let self = self else {return}
                guard let _movie = movie else {return}
                self.movieArray = _movie
                self.moviewDataSourceArray =  self.moviewDataSourceArray + self.movieArray 
                completionBlock(movie!)
            }
        }
    }
    
    func getParticularMovies(endPoint:String,completionBlock : @escaping completionBlock){
        let service = Service(baseUrl: ViewController.baseUrl!)
        service.getMovie(endPoint: endPoint)
        service.completionHandler {(movie, status, message) in
            if status {
                completionBlock(movie!)
            }
        }
    }
    
    func getNumberOfRowsInSection() -> Int{
        if MoviesViewController.flag == true {
            return searchedDataSourceArray.count
        }
        return moviewDataSourceArray.count
    }
    
    func getMovieAtIndex(index : Int) -> Movie{
        if MoviesViewController.flag == true {
            let movie = self.searchedDataSourceArray[index]
            return movie
        }
        let movie = self.moviewDataSourceArray[index]
        return movie
    }
    
    func getCellData(index : Int) -> Movie{
        let movie = self.getMovieAtIndex(index: index)
        return movie
    }
    
    func search(text: String) {
        searchedDataSourceArray = moviewDataSourceArray.filter { $0.title!.localizedCaseInsensitiveContains(text)}
    }
    
    func parseConfig() -> Config {
        let url = Bundle.main.url(forResource: "Config", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(Config.self, from: data)
    }
}
