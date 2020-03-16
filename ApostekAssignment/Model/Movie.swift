//
//  Movie.swift
//  ApostekAssignment
//
//  Created by OMAR on 14/03/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import Foundation
import UIKit

struct Movies: Codable {
    var results: [Movie]
}
struct Movie: Codable {
    var id : Int?
    var poster_path: String?
    var title : String?
    var vote_average : Double?
    var release_date : String?
    var overview : String?
    var vote_count : Double?
}
