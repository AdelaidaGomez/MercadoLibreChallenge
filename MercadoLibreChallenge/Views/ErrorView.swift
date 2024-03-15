//
//  ErrorView.swift
//  MercadoLibreChallenge
//
//  Created by Adelaida Gomez Vieco on 15/03/24.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var searchResponseVM = SearchResponseViewModel()
    @Binding var errorMessage: String
    @StateObject var networkingClass = NetworkingClass()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 20) {
                
                Image("errorImage")
                    .resizable()
                    .scaledToFit()
                    .padding(60)
                
                Text("Ooops!")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Text("\(errorMessage)")
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    ErrorView(errorMessage: .constant("your network connection"))
}
