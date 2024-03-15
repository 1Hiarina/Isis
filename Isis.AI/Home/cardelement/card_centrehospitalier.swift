//
//  card4_home.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 06/02/2024.
//

import SwiftUI

struct card_centrehospitalier: View {
    var body: some View {
        ZStack {
            Image("Screenshot 2024-03-15 at 09.45.26")
                .resizable()
                .blur(radius: 4)
            HStack {
                Text("CENTRE HOSPITALIER AUTOUR DE MOI")
                    .font(.custom("Gilmer Bold", size: 16))
                    .foregroundColor(.white)
                
            }
            .frame(width: 320, height: 50)
            .cornerRadius(10)
            .offset(x:10, y: 10)
            .shadow(radius: 3)
                

        }
        .frame(width: 360, height: 150)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    card_centrehospitalier()
}
