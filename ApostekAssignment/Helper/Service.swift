//
//  Service.swift
//  ApostekAssignment
//
//  Created by OMAR on 14/03/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    typealias countriesCallBack = (_ movie:[Movie]?, _ status: Bool, _ message:String) -> Void
    var callBack:countriesCallBack?
    fileprivate var baseUrl = ""
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    //MARK:- getAllProductsFromCollection
    func getMovie(endPoint:String) {
        AF.request(self.baseUrl + endPoint , method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                return
            }
            do {
            let movies = try JSONDecoder().decode(Movies.self, from: data)
                self.callBack?(movies.results, true,"")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    func completionHandler(callBack: @escaping countriesCallBack) {
        self.callBack = callBack
   }
}
