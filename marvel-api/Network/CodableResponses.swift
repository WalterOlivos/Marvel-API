//
//  CodableResponses.swift
//  marvel-api
//
//  Created by Walter Oliveira on 08/11/18.
//  Copyright © 2018 Walter Oliveira. All rights reserved.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let data: MarvelResults<T>
}

struct MarvelResults<T: Codable>: Codable {
    let results: [T]
    let total: Int
}
