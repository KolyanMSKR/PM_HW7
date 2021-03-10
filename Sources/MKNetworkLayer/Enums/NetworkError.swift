//
//  NetworkError.swift
//  
//
//  Created by Mykola Korotun on 08.03.2021.
//

import Foundation

public enum NetworkError: String, Error {
    case dataTaskError = "Data task error"
    case invalidData = "Invalid data"
    case invalidJSONData = "Invalid json data"
    case invalidResponseStatusCode = "Invalid response status code"
    case failureStatusCode = "Failure status code"
}
