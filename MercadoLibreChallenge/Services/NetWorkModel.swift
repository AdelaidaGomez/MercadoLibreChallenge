//
//  NetWorkModel.swift
//  MercadoLibreChallenge
//
//  Created by Adelaida Gomez Vieco on 12/03/24.
//

import Foundation

// Define the possible states in which a request is found
enum ResultState {
    case loading
    case success
    case failed
}

// Define our own error message handling
enum NetworkError: Error, Equatable {
    case invalidURL
    case encodingFailed
    case errorInTask(String)
    case statusCodeNo2xx(message: String)
    case decodingFailed
    case noBodyResponse
    case unexpected(Int)
    case otherError
}

// Define our own error descriptions
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Could not open the page because the adress is invalid"
        case .encodingFailed:
            return "Something went wrong. Please try again (ERROR_CONTENT_ENCODING_FAIL)"
        case .errorInTask:
            return "No Internet Connection Found. Please check your internet connection and try again."
        case .statusCodeNo2xx:
            return "The requested information is temporarily unavailable. Please try again later."
        case .decodingFailed:
            return "There was an issue loading the content. Please refresh the page or try again later."
        case .noBodyResponse:
            return "A network error occurred. If the error continues, please contact service."
        case .unexpected(let code):
            return "Unexpected Error. The operation could't be completed (\(code))."
        case .otherError:
            return "It seems we're experiencing technical difficulties. We apologize for the inconvenience."
        }
    }
}

// Define the types of HTTP request that we are going to handle
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

// Define the type of data that we will use in the generic function, for when the response is different than 2xx
struct ServidorResponseNo2xx: Codable {
    let message: String
    let error: String
    let status: Int
    let cause: [String]
}
