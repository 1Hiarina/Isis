//
//  card_document2.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 07/02/2024.
//

import SwiftUI

struct card_circle_plus: View {
    var body: some View {
        VStack {
            Image(systemName: "plus").font(.title).foregroundColor(.white)
            
        }
        .frame(width: 70, height: 70)
        .background(.gradient2)
        .cornerRadius(35)
        .shadow(radius: 7)
    }
}

#Preview {
    card_circle_plus()
}
