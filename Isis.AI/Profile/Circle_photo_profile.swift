//
//  Cirlcle_photo_profile.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 29/02/2024.
//

import SwiftUI

struct Circle_photo_profile: View {
    var body: some View {
        VStack {
            Image("default_avatar")
                .resizable()
        }
        .frame(width: 100, height: 100)
        .background(.gray)
        .cornerRadius(200)

    }
}

#Preview {
    Circle_photo_profile()
}
