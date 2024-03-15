//
//  card2_home.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 06/02/2024.
//

import SwiftUI

struct card_depistage: View {
    var body: some View {
        VStack {
            VStack {
                
                Image("istockphoto-1399809420-612x612")
                    .resizable()
                    .frame(width: 170, height: 170)
               
                VStack {
                    Text("SE FAIRE DÉPISTER")
                        .font(.custom("Gilmer Bold", size: 13))
                        .padding()
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
    card_depistage()
}

