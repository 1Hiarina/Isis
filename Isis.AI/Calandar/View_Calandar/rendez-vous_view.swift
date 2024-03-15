//
//  rendez-vous_view.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 06/02/2024.
//

import SwiftUI

struct rendez_vous_view: View {
    var body: some View {
        ScrollView {
            Text("A venir")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .fontWeight(.semibold)
            card_rendez_vous()
            card_rendez_vous()
            Text("Mes consultations")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .fontWeight(.semibold)
            card_rendez_vous()

            
        }
        .padding(.top, 80)
    }
}

#Preview {
    rendez_vous_view()
}
