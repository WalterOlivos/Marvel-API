//
//  Characters.swift
//  marvel-api
//
//  Created by Walter Oliveira on 05/11/18.
//  Copyright © 2018 Walter Oliveira. All rights reserved.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let description: String?
    let thumbnail: Thumbnail
}

extension Character {
    struct Thumbnail: Codable {
        let path: String
        let `extension`: String
        
        var url: URL {
            return URL(string: path + "/standard_fantastic." + `extension`)!
        }
    }
}

