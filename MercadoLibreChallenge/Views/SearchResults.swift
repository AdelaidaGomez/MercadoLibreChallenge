//
//  SearchResults.swift
//  MercadoLibreChallenge
//
//  Created by Adelaida Gomez Vieco on 15/03/24.
//

import SwiftUI

struct SearchResults: View {
    var items: [Items]
    let imageURLString = "http://http2.mlstatic.com/D_946897-MLU69777374320_062023-I.jpg"
    
    let columns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {

                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(items) { item in
                        NavigationLink(destination: ItemDetailView(item: item, productAttributes: item.productAttributes)){
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white)
                                    .frame(width: 170, height: .infinity)
                                    .cornerRadius(10.0)
                                
                                VStack(alignment: .center) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        
                                        AsyncImage(url: URL(string: item.thumbnail)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Image("noImageAvailable")
                                        }
                                        .frame(width: 120, height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .padding(9)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            HStack(spacing: 2) {
                                                ForEach(0..<5) { item in
                                                    Image(systemName: "star.fill")
                                                        .font(.system(size: 8))
                                                        .foregroundColor(.blue)
                                                }
                                            }
                                            
                                            Text(item.title)
                                                .font(.system(size: 12))
                                                .foregroundColor(.black)
                                                .multilineTextAlignment(.leading)
                                            
                                        }
                                        .padding(.horizontal)
                                        
                                    }
                                    .frame(width: 170, height: .infinity)
                                    
                                    Text("$2.419.900")
                                        .font(.title3.bold())
                                        .foregroundColor(.black)
                                        .padding(.bottom)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SearchResults(items: [Items(id: "Example", title: "Example", condition: "New", price: 2222999, thumbnail: "http://http2.mlstatic.com/D_946897-MLU69777374320_062023-I.jpg", shipping: Shipping(storePickUp: true, freeShipping: true), seller: Seller(id: 2, nickname: "Juan Jose Perez"), availableQuantity: 5, productAttributes: [ProductAttributes(id: "Brand", name: "Marca", valueName: "Motorola")])])
}
