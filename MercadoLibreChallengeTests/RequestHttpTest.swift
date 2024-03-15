//
//  RequestHttpTest.swift
//  MercadoLibreChallengeTests
//
//  Created by Adelaida Gomez Vieco on 15/03/24.
//

import XCTest
@testable import MercadoLibreChallenge

class RequestHttpTests: XCTestCase {
    //Valid parameters (When Need of parameters)
    func testRequestHttpWithValidParameters() {
        // Given Arrange
        let searchResponseVM = SearchResponseViewModel()
        let networking = NetworkingClass()
        let method: HTTPMethod = .get
        let url = "https://api.mercadolibre.com/sites/MCO/search?q=Motorola%20G6"
        let parameters: [String:String]? = ["email": "Example", "password": "Example"]
        
        // When Act
        networking.requestHttp(method: method, url: url, parameters: parameters, responseType2xx: SearchResponse.self, responseTypeNo2xx: ServidorResponseNo2xx.self) { result in
            // Then Assert
            switch result {
            case .success(let value):
                // Verify the success case
                XCTAssertNotNil(DispatchQueue.main.async {
                    searchResponseVM.searchResponse.append(value)
                    searchResponseVM.resultState = .success
                })
                // Add more assertions as needed
            case .failure(let error):
                // Fail the test if there's an error
                XCTFail("Error: \(error)")
            }
        }
    }
    //Invalid URL
    func testRequestHttpWithInvalidURL() {
        // Arrange
        let networking = NetworkingClass()
        let method: HTTPMethod = .get
        let url = ""
        let parameters: [String:String]? = ["email": "Example", "password": "Example"]

        // Create an expectation
        let expectation = XCTestExpectation(description: "Invalid URL request should fail")

        // Act
        networking.requestHttp(method: method, url: url, parameters: parameters, responseType2xx: SearchResponse.self, responseTypeNo2xx: ServidorResponseNo2xx.self) { result in
            // Assert
            switch result {
            case .success:
                // Fail the test if there's a success
                XCTFail("The request should fail with an invalid URL")
            case .failure(let error):
                // Print the error message for debugging
                print("Error received: \(error)")
                XCTAssertEqual(error, NetworkError.invalidURL)
                // Fulfill the expectation
                expectation.fulfill()
            }
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5)
    }
    
    //Status code No2xx decode ServidorResponseNo2xx and manage errors
    func testRequestHttpWithStatusCodeNo2xx() {
        // Arrange
        let searchResponseVM = SearchResponseViewModel()
        let networking = NetworkingClass()
        let method: HTTPMethod = .get
        let url = "https://api.mercadolibre.com/sites/CO/search?q=InvalidQuery"
        let parameters: [String:String]? = ["email": "Example", "password": "Example"]

        // Create an expectation
        let expectation = XCTestExpectation(description: "Status code no 2xx should fail")

        // Act
        networking.requestHttp(method: method, url: url, parameters: parameters, responseType2xx: SearchResponse.self, responseTypeNo2xx: ServidorResponseNo2xx.self) { result in
            // Assert
            switch result {
            case .success:
                // Fail the test if there's a success
                XCTFail("The request should fail with a status code not in 2xx range")
            case .failure(let error):
                // Print the error message for debugging
                print("Error received: \(error)")
                // Verify that the error is due to a status code not in 2xx range
                XCTAssertNotNil(DispatchQueue.main.async {
                    searchResponseVM.errorResponse = error.localizedDescription
                    searchResponseVM.resultState = .failed
                })
                XCTAssertEqual(error, NetworkError.statusCodeNo2xx(message: "The requested information is temporarily unavailable. Please try again later."))
                // Fulfill the expectation
                expectation.fulfill()
            }
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5)
    }
    
    //Decoding Fail for 2xx response and responseType2xx
    func testRequestHttpWithDecodingFailed() {
        // Arrange
        let networking = NetworkingClass()
        let method: HTTPMethod = .get
        let url = "https://api.mercadolibre.com/sites/MCO/search?q=ValidQuery"
        let parameters: [String:String]? = ["email": "Example", "password": "Example"]

        // Create an expectation
        let expectation = XCTestExpectation(description: "Decoding failure should fail")

        // Act
        networking.requestHttp(method: method, url: url, parameters: parameters, responseType2xx: ServidorResponseNo2xx.self, responseTypeNo2xx: ServidorResponseNo2xx.self) { result in
            // Assert
            switch result {
            case .success:
                // Fail the test if there's a success
                XCTFail("The request should fail with a decoding error")
            case .failure(let error):
                // Print the error message for debugging
                print("Error received: \(error)")
                // Verify that the error is due to a decoding failure
                XCTAssertEqual(error, NetworkError.decodingFailed)
                // Fulfill the expectation
                expectation.fulfill()
            }
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5)
    }
}
