//
//  SearchResponse.swift
//  MercadoLibreChallenge
//
//  Created by Adelaida Gomez Vieco on 15/03/24.
//

import Foundation

struct SearchResponse: Decodable {
    let results: [Items]
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

//Item (result) struct
struct Items: Identifiable, Decodable {
    let id: String
    let title: String
    let condition: String
    let price: Int
    let thumbnail: String
    let shipping: Shipping
    let seller: Seller
    let availableQuantity: Int
    let productAttributes: [ProductAttributes]
    
    enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case condition = "condition"
            case thumbnail = "thumbnail"
            case price = "price"
            case availableQuantity = "available_quantity"
            case shipping = "shipping"
            case seller = "seller"
            case productAttributes = "attributes"
        }
}

//Shipping Struct
struct Shipping: Codable {
    let storePickUp: Bool
    let freeShipping: Bool

    enum CodingKeys: String, CodingKey {
        case storePickUp = "store_pick_up"
        case freeShipping = "free_shipping"
    }
}

//Seller Struct
struct Seller: Codable {
    let id: Int
    let nickname: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nickname = "nickname"
    }
}

//Attribute Struct
struct ProductAttributes: Codable, Identifiable {
    let id: String
    let name: String
    let valueName: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case valueName = "value_name"
        
    }
}
