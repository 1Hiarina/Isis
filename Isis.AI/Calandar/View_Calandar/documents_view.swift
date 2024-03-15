//
//  documents_view.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 06/02/2024.
//

import SwiftUI

struct documents_view: View {
    
    var body: some View {

    
        ZStack {
            
            ScrollView {
                HStack {
                    NavigationLink(destination: add_doc_View()) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.black)
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 120))
                    ], spacing: 10) {
                        ForEach(0..<5) { index in
                            card_documents()
                        }
                    }
                    .padding(10)
            }
            .padding(.top, 80)

            NavigationLink(destination: add_doc_View()) {
                card_circle_plus()
                    .frame(maxWidth: .infinity,maxHeight: 700 ,alignment: .bottomTrailing)
                    .padding()
            }
        }
    }
}

#Preview {
    documents_view()
}




