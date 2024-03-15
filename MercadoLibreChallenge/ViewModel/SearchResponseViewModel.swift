//
//  SearchResponseViewModel.swift
//  MercadoLibreChallenge
//
//  Created by Adelaida Gomez Vieco on 15/03/24.
//

import Foundation

class SearchResponseViewModel: ObservableObject {
    @Published var resultState = ResultState.loading
    @Published var errorResponse = ""
    @Published var searchResponse: [SearchResponse] = []
}
