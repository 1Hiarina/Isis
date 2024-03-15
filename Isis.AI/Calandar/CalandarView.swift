
import SwiftUI

struct CalandarView: View {
    @State var currentTab: Int = 0
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                TabView(selection: self.$currentTab) {
                    rendez_vous_view().tag(0)
                    documents_view().tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.bottom)
                
                TabBarView(currentTab: self.$currentTab)
            }
        }
    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace


    var tabBarOptions: [String] = ["Rendez-vous", "Documents"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Array(zip(self.tabBarOptions.indices,
                                  self.tabBarOptions)),
                        id: \.0,
                        content: {
                    index, name in
                    TabBarItem(currentTab: self.$currentTab,
                               namespace: namespace.self,
                               tabBarItemName: name,
                               tab: index)
                    
                })
            }
            .padding(.horizontal)
        }
        .background(.gradient2)
        .frame(height: 100)
        .edgesIgnoringSafeArea(.all)
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                    .foregroundColor(.white)
                if currentTab == tab {
                    Color.white
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace,
                                               properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CalandarView()
}
