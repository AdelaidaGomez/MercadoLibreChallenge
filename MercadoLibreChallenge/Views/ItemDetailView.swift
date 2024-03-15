//
//  ItemDetailView.swift
//  MercadoLibreChallenge
//
//  Created by Adelaida Gomez Vieco on 15/03/24.
//

import SwiftUI

struct ItemDetailView: View {
    //HideView
    @Environment(\.dismiss) var dismiss
    
    let item: Items
    //Attributes
    let productAttributes: [ProductAttributes]
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.black)
                            .padding(.top, 30)
                            .padding(.horizontal)
                    }
                    VStack(alignment: .center) {
                        ZStack(alignment: .topTrailing) {
                            //Image from URL
                            AsyncImage(url: URL(string: item.thumbnail)) { image in
                                image
                                    .resizable()
                                    .frame(width: 150, height: 150)
                            } placeholder: {
                                Image("noImageAvailable")
                            }
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        
                        //Item info
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.title.bold())
                            
                            HStack(spacing: 4) {
                                ForEach(0..<5) { item in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.blue)
                                }
                                Text("(4.9)")
                                    .opacity(0.5)
                                    .padding(.leading, 8)
                                Spacer()
                            }
                            
                            Text("Description")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .padding(.vertical)
                            
                            ForEach(productAttributes) { attribute in
                                HStack{
                                    Text("\(attribute.name): ")
                                        .foregroundColor(.black.opacity(0.8))
                                    Text(attribute.valueName ?? "")
                                }
                                .foregroundColor(.gray)
                            }
                            
                            Text("Seller Information")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .padding(.vertical)
                            
                            Text(item.seller.nickname)
                                .foregroundColor(.gray)
                        }
                        
                        Button {
                           //Payment Button
                        } label: {
                            Text("Buy Now")
                                .foregroundColor(.white)
                                .padding(.horizontal, 100)
                                .padding(.vertical)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .frame(height: 35)
                        .padding(.vertical)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ItemDetailView(item: Items(id: "Example", title: "Exampleeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee", condition: "New", price: 22999, thumbnail: "http://http2.mlstatic.com/D_946897-MLU69777374320_062023-I.jpg", shipping: Shipping(storePickUp: true, freeShipping: true), seller: Seller(id: 2, nickname: "Juan Jose Perez"), availableQuantity: 5, productAttributes: [ProductAttributes(id: "Brand", name: "Marca", valueName: "Motorola")]), productAttributes: [ProductAttributes(id: "BRAND", name: "MOTOROLA", valueName: "G6 MOTOROLA"), ProductAttributes(id: "BRAND", name: "XBOX", valueName: "X1XBOX")])
}
