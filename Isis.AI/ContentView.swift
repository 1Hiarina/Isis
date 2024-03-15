//
//  ContentView.swift
//  Isis.AI
//
//  Created by Hiarina Rakotoarivelo on 05/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "network")
                }
            CalandarView()
                .tabItem {
                    Image(systemName: "calendar")
                }
         
            IsisView()
                .tabItem {
                    Image(systemName: "aqi.medium")
                }
            Conf_MessageView()
                .tabItem {
                    Image(systemName: "video.fill")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .tint(.green2)
    }
}

#Preview {
    ContentView()
}


