//
//  Resource.swift
//  
//
//  Created by Mykola Korotun on 08.03.2021.
//

import Foundation

public struct Resource {

    var baseURL: URL
    var httpMethod: HTTPMethod
    var httpBody: Data?
    var headers: [String: String]

    public init(baseURL: URL,
                headers: [String: String],
                httpMethod: HTTPMethod = .get,
                httpBody: Data? = nil) {

        self.baseURL = baseURL
        self.httpMethod = httpMethod
        self.httpBody = httpBody
        self.headers = headers
    }

}
