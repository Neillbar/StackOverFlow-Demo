//
//  FailureResultModel.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/16.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import Foundation

enum APIError: Error {
    case apiError
    case badResponse
    case InvalidJSONData // an error during the parsing of the json response
    case unknown(String) // some unknown error
    case statusCode(StatusCodeError)
}

enum StatusCodeError: Int{
    case internal_error = 500
    case throttle_violation = 502
    case temporarily_unavailable = 503
}
