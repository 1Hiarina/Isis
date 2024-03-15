//
//  card1_home.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 06/02/2024.
//

import SwiftUI

struct card1_home: View {
    var body: some View {
        VStack {
            Text("TROUVEZ VOTRE PRATICIEN ")
                .foregroundColor(.white)
                .font(.custom("Gilmer Heavy", size: 15))
                .padding(5)
            NavigationLink(destination: Find_doctorView()) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("RECHERCHER")
                        .foregroundColor(.black)
                        .opacity(0.3)
                    
                }
                .frame(width: 250, height: 40)
                .background(.white)
                .cornerRadius(50)
            }
        }
        .frame(width: 350, height: 200)
        .background(.gradient2)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    card1_home()
}
