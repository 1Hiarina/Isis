//
//  card2_home.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 06/02/2024.
//

import SwiftUI

struct card_don_sang: View {
    var body: some View {
        VStack {
            VStack {
                
                Image("aide-modernisation-283x300")
                    .resizable()
                    .frame(width: 170, height: 170)
               
                VStack {
                    Text("DONNEZ VOTRE SANG")
                        .font(.custom("Gilmer Bold", size: 12))
                        .padding(2)
                    .foregroundColor(.white)
                }
                .frame(width: 160, height: 40)
                .background(.gradient2)
                .cornerRadius(10)
                .shadow(radius: 10)
                
            }
        }
        .frame(width: 170, height: 240)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    card_don_sang()
}
