//
//  Config.swift
//  Assignment
//
//  Created by localhost on 04/03/20.
//  Copyright © 2020 localhost. All rights reserved.
//

import Foundation
struct Config: Codable {
    let baseUrl: String?
    let imageBaseUrl: String?
    let endPoint: String?
    let popularEndPoint: String?
    let topRelatedEndPoint: String?
    let discoverEndPoint: String?
    private enum CodingKeys: String, CodingKey {
        case baseUrl, imageBaseUrl, endPoint,popularEndPoint,topRelatedEndPoint,discoverEndPoint
    }
}
