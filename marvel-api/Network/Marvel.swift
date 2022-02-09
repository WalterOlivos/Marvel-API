//
//  Marvel.swift
//  marvel-api
//
//  Created by Walter Oliveira on 08/11/18.
//  Copyright © 2018 Walter Oliveira. All rights reserved.
//

import Foundation
import Moya
import CommonCrypto

public enum Marvel {
    static private let privateKey = "1c21f8364ed5aacab48d237f7edc162c9c4d2939"
    static private let publicKey = "038ff55d86cdc6fbe7be27d8e66c96ac"
    
    case characters(offset: Int)
    case comics(offset: Int, id: Int)
    
}

extension Marvel: TargetType {
    public var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443/v1/public")!
    }
    
    public var path: String {
        switch self {
        case .characters: return "/characters"
        case .comics(_, let id): return "/characters/\(id)/comics"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .characters: return .get
        case .comics: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {

        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5
        
        switch self {
            
        case .characters(let charOffset):
            return .requestParameters(parameters: [
                "offset": charOffset,
                "limit": 20,
                "apikey": Marvel.publicKey,
                "ts": ts,
                "hash": hash
            ], encoding: URLEncoding.queryString)
            
        case .comics(let comicOffset, let id):
            return .requestParameters(parameters: [
                "characterId": id,
                "offset": comicOffset,
                "limit": 20,
                "apikey": Marvel.publicKey,
                "ts": ts,
                "hash": hash
                ], encoding: URLEncoding.queryString)
            
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
