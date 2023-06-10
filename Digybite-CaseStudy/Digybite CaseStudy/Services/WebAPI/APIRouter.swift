//
//  APIRouter.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 02/06/2023.
//

import Foundation
import Alamofire
//import SwiftyJSON

enum APIRouter: URLRequestConvertible {
    
    //TODO: APIs
    case gamesList
    case gamelistDetails(id: Int)
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIConstants.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        //urlRequest.allHTTPHeaderFields = header
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.queryString
                //                return URLEncoding.queryString
            case .post:
                return JSONEncoding.default
                //                return URLEncoding.queryString
                
            case .delete:
                return URLEncoding.default
            default:
                return URLEncoding.queryString
                
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
        
    }
    
    //MARK: - Header
//    private var header: [String: String] {
//
//        switch self {
//        case .gamesList:
//            return [ "":""
//               // APIConstants.HttpHeaderField.ApiKey.rawValue: APIConstants.apiKey
//            ]
//        }
//
//    }
    
    //MARK: - HttpMethod
    // changable //post, get, ....
    private var method: HTTPMethod {
        switch self {
        case .gamesList, .gamelistDetails:
            return .get
        }
    }
    
    //MARK: - Path
    //The path is the part following the base url
    // changable
    var path: String {
        switch self {
            
        case .gamesList:
            return "/games"
        case .gamelistDetails(let id):
            return "/games/\(id)"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
            
        case .gamesList, .gamelistDetails:
            return nil
        }
    }
    
}
