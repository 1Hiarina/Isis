//
//  card_rendez-vous.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 06/02/2024.
//

import SwiftUI

struct card_rendez_vous: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 50, height: 50)
                        .background(
                            Image("default_avatar")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                            .shadow(radius: 6)
                    )
                    .cornerRadius(45)
                }
                .padding()
                VStack {
                    Text("Mme Nathalie Daco")
                        .font(.custom("", size: 18))
                        .fontWeight(.semibold)
                    Text("Médecin généraliste")
                        .font(.custom("", size: 16))

                    Text("7 Février - 10h30")
                        .font(.custom("", size: 15))
                }
                VStack {
                    NavigationLink(destination: Consultation_resum_view()) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                    
                }
                .frame(width: 50, height: 50)
                .background(.white)
                .cornerRadius(20)
            }
        }
        .frame(width: 350, height: 80)
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 5)
    }
}

#Preview {
    card_rendez_vous()
}
