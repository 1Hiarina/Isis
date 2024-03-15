import SwiftUI

struct CustomTitle_Home: View {
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: "aqi.medium")
                .foregroundColor(.green2)
            Text(title)
                .font(.custom("Inter-VariableFont_slnt,wght", size: 30))
            
            Spacer(minLength: 160)
            
            NavigationLink(destination: Qr_code_View()){
                VStack {
                    Image(systemName: "qrcode")
                        .frame(width: 20, height: 20)
                        .padding()
                        .foregroundColor(.black)
                }
                .frame(width: 35, height: 35)
                .background(.white)
                .cornerRadius(25)
                .shadow(radius: 2)
            }
            
            
            
            
            NavigationLink(destination: Notification_View()){
                VStack {
                    Image(systemName: "bell")
                        .frame(width: 20, height: 20)
                        .padding()
                        .foregroundColor(.black)
                }
                .frame(width: 35, height: 35)
                .background(.white)
                .cornerRadius(25)
                .shadow(radius: 2)
            }
            
        }
    }
}

struct HomeView: View {

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    card1_home()
                        .padding()
                    HStack(spacing: 10){
                        
                        NavigationLink(destination: depistage_rendez_vous_View()){
                            card_depistage()
                        }
                        Button(action: {
                                       if let url = URL(string: "https://dondesang.efs.sante.fr/trouver-une-collecte") {
                                           UIApplication.shared.open(url)
                                       }
                                   })
                        {
                            card_don_sang()
                            
                        }
                        
                                   
                        
                    }
                    .padding(.bottom)
                    
                    NavigationLink(destination: find_hospitalView()) {
                        card_centrehospitalier()
                    }
                    card5_home()
                        .padding()
                    
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: CustomTitle_Home(title: "ISIS"))
        }
    }
}

struct HomeView_provider: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

