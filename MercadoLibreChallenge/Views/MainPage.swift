//
//  MainPage.swift
//  MercadoLibreChallenge
//
//  Created by Adelaida Gomez Vieco on 15/03/24.
//

import SwiftUI

struct MainPage: View {
@ObservedObject var searchResponseVM = SearchResponseViewModel()
//Search
@State var searchText = ""

@State var errorMessage = ""

@StateObject var networkingClass = NetworkingClass()

var body: some View {
    VStack {
        
        switch searchResponseVM.resultState {
        case .loading:
            Text("Loading data...")
            ProgressView()
        case .failed:
            ErrorView(errorMessage: $errorMessage)
        case .success:
                ZStack {
                    LinearGradient(colors: [Color("yellowML"), Color("yellowML").opacity(0.3), Color("bg")], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    ScrollView{
                        SearchView(searchText: $searchText)
                        
                        SearchResults(items: searchResponseVM.searchResponse.flatMap { $0.results }.filter {
                            searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText)
                        })
                    }
                }
        }
    }
    .onAppear {
        // Fetch data when view appears
        performSearch()
    }
    //Trigger function while user is typing
    .onChange(of: searchText, performSearch)
}

func performSearch() {
    let siteID = "MCO" //This can be change in a settingView (based on region)
    let urlString = "https://api.mercadolibre.com/sites/\(siteID)/search?q=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
    
    
    //Calling Request function
    networkingClass.requestHttp(method: .get, url: urlString, parameters: nil as String?, responseType2xx: SearchResponse.self, responseTypeNo2xx: ServidorResponseNo2xx.self) { result in
        switch result {
        case .success(let respuesta):
            DispatchQueue.main.async {
                //Change state of resultState and decode with structure
                searchResponseVM.searchResponse.append(respuesta)
                searchResponseVM.resultState = .success
            }
        case .failure(let error):
            DispatchQueue.main.async {
                //Change state of resultState and decode with structure
                searchResponseVM.errorResponse = error.localizedDescription
                searchResponseVM.resultState = .failed
                errorMessage = searchResponseVM.errorResponse
            }
        }
    }
}
}

#Preview {
    MainPage()
}
