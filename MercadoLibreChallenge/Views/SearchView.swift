//
//  SearchView.swift
//  MercadoLibreChallenge
//
//  Created by Adelaida Gomez Vieco on 15/03/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    //Mock data for UI
    let categories = ["Computacion", "Deportes", "carros", "Inmuebles", "Electronica"]
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "list.dash")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10.0)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10.0)
                    }
                }
                .padding(.horizontal)
                
                if searchText.isEmpty {
                    VStack(alignment: .leading){
                        Text("Codo  a codo")
                            .foregroundColor(.black)
                        Text(" en las dificiles")
                            .foregroundColor(.blue)
                    }
                    .font(.title.bold())
                    .padding(.leading)
                }
                
                
                
                
                //SearchBar
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.trailing, 8)
                        
                        TextField("", text: $searchText)
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                            .keyboardType(.default)
                            .autocorrectionDisabled(true)
                        
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                withAnimation{
                                    self.searchText = ""
                                }
                            }
                    }
                    .padding(.all, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .cornerRadius(10.0)
                    .padding(.trailing)
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10.0)
                    }
                }
                .padding(.horizontal)
                
                //Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<categories.count) { i in
                            Text(categories[i])
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundColor(Color.black)
                        }
                        .padding(.trailing)
                    }
                    .padding()
                }
            }
        }
        //        ZStack {
        //            Color.clear
        //                .ignoresSafeArea()
        //            VStack {
        //                HStack{
        //                    if searchText.isEmpty {
        //                        Text("Codo a codo en las difíciles")
        //                            .font(.title.bold())
        //                            .multilineTextAlignment(.leading)
        //                    }
        //                    Image("logo")
        //                        .resizable()
        //                        .scaledToFit()
        //                        .frame(width: 100, height: 100)
        //                }
        //                .padding(.horizontal)
        //
        //
        //                        HStack {
        //                            Image(systemName: "magnifyingglass")
        //                                .foregroundColor(searchText.isEmpty ? Color.gray : Color.black)
        //
        //                            TextField("", text: $searchText)
        //                                .foregroundColor(.black)
        //                                .fontWeight(.regular)
        //                                .keyboardType(.default)
        //                                .autocorrectionDisabled(true)
        //
        //                            Image(systemName: "xmark.circle.fill")
        //                                .foregroundColor(.black)
        //                                .opacity(searchText.isEmpty ? 0.0 : 1.0)
        //                                .onTapGesture {
        //                                    withAnimation{
        //                                        self.searchText = ""
        //                                    }
        //                                }
        //                        }
        //                        .font(.headline)
        //                        .padding(10)
        //                        .background(
        //                            RoundedRectangle(cornerRadius: 10)
        //                                .stroke(Color.gray, lineWidth: 2)
        //                        )
        //                        .padding(.horizontal)
        //
        //                ScrollView(.horizontal, showsIndicators: false) {
        //                    HStack(spacing: 20) {
        //                        ForEach(categories, id: \.self) { category in
        //                            ZStack{
        //                                RoundedRectangle(cornerRadius: 5)
        //                                    .foregroundColor(.black.opacity(0.9))
        //                                    .frame(width: .infinity, height: 40)
        //
        //                                HStack{
        //                                    Image(systemName: "pencil.circle.fill")
        //
        //                                    Text(category)
        //                                }
        //                                .foregroundColor(.white)
        //                                .padding(.horizontal)
        //                            }
        //                        }
        //                    }
        //                    .padding(.horizontal)
        //                    .padding(.vertical, 20)
        //                }
        //            }
        //            .padding(.top, 50)
        //        }
    }
}

#Preview {
    SearchView(searchText: .constant(""))
}
