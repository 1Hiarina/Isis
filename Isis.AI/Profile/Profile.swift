import SwiftUI


struct ProfileView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
                HStack(spacing: 10) {
                    Circle_photo_profile()
                        .frame(width: 100, height: 100)
                        .padding()
                    VStack(alignment: .leading) {
                        Text("Hiarina")
                            .font(.custom("R", size: 20))
                        Text("Rakotoarivelo")
                        NavigationLink(destination: Profile_modifierView()) {
                            Text("Modifier mon profil")
                                .font(.custom("", size: 15))
                                .foregroundColor(.white)
                                .frame(width: 150, height: 35)
                                .background(.gradient4)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                
                
                HStack(spacing: 20) {
                    NavigationLink(destination: Profile_topitem1()) {
                        VStack {
                            Image(systemName: "heart.text.square")
                                .foregroundColor(.gradient4)
                                .font(.title)
                        }
                        .frame(width: 100, height: 70)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                    }
                    
                    
                    NavigationLink(destination: Profile_topitem2()) {
                        VStack {
                            Image(systemName: "cross.vial")
                                .foregroundColor(.gradient4)
                                .font(.title)
                        }
                        .frame(width: 100, height: 70)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                    }
                    
                    NavigationLink(destination: Profile_topitem3()) {
                        VStack {
                            Image(systemName: "pill")
                                .foregroundColor(.gradient4)
                                .font(.title)
                        }
                        .frame(width: 100, height: 70)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                    }
                }
                .padding()
                
                Information_1_cardView()
                    .padding()
                
                HStack(spacing: 10) {
                    Information_2_cardView()
                    Information_3_cardView()
                }
                .padding(.bottom)
                .padding(.top)
                
                Period_Track_cardView()
                    .padding()
                
                
                
                Text("Isys Technologies")
                    .font(.custom("", size: 15))
                    .foregroundColor(.gray)
                Text("@All Right reserved")
                    .font(.custom("", size: 15))
                    .foregroundColor(.gray)
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

