//
//  Conf_MedView.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 04/03/2024.
//

import SwiftUI



struct Conf_MessageView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0 ..< 7) { item in
                        NavigationLink(destination: Chat_View()) {
                            VStack {
                                HStack {
                                    VStack {
                                        Image("default_avatar")
                                            .resizable()
                                    }
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(35)
                                    .padding(10)
                                    VStack {
                                        Text("Natalie Daco")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.custom("",size: 18))
                                            .foregroundColor(.black)
                                            .padding(1)
                                        Text("Bonjour, votre rendez-vous est prevu a 14h")
                                            .foregroundColor(.gray)
                                            .font(.custom("",size: 15))

                                    }
                                    .frame(width: 200, height: 50)
                                    Text("14/02")
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(width: 450, height: 90)
                            .background(.white)
                            .shadow(radius: 1)
                        }
                    }

                    
                    VStack {
                        Text("Isys Technologies")
                            .font(.custom("", size: 15))
                            .foregroundColor(.gradient3)
                        Text("@All Right reserved")
                            .font(.custom("", size: 15))
                            .foregroundColor(.gradient3)

                    }
                    .padding()
                }
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    Conf_MessageView()
}
