//
//  StatusCodes.swift
//  
//
//  Created by Mykola Korotun on 08.03.2021.
//

import Foundation

enum StatusCodes {
    case success
    case fail

    public var value: Range<Int> {
        switch self {
        case .success:
            return 200..<300
        case .fail:
            return 300..<600
        }
    }
}
