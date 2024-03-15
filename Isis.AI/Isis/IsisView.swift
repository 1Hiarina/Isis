import SwiftUI

struct CustomTitle: View {
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: "aqi.medium")
            Text(title)
                .font(.custom("Inter-VariableFont_slnt,wght", size: 30))
        }
    }
}

struct IsisView: View {
    
    let categories: [String: (Int, String)] = [
        "Digestion": (0, "139355"),
        "Cœur": (1, "954528"),
        "Cerveau": (2, "883039"),
        "Infections sexuels": (3, "2492776"),
        "Poumons": (4, "1881195"),
        "Système immunitaire": (5, "2865511"),
        "Hormones et métabolisme": (6, "4144999"),
        "Articulations et muscles": (7, "84289"),
        "Peau": (8, "5059513")
    ]
    
    @State private var selectedCategory: Int? = nil
    @State private var isPredictionVisible: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Fond_app")
                    .resizable()
                    .blur(radius: 40)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                        ForEach(categories.sorted(by: { $0.value.0 < $1.value.0 }), id: \.key) { category in
                            NavigationLink(destination: Isis_prediction_View(), tag: category.value.0, selection: $selectedCategory) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Image(category.value.1)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .padding()
                                    Text(category.key)
                                        .font(.custom("Inter-VariableFont_slnt,wght", size: 15))

                                }
                                .frame(width: 100, height: 150)
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .onTapGesture {
                                    selectedCategory = category.value.0
                                    sendCategoryValue(category.value.0)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: CustomTitle(title: "ISIS IA"))
            }
        }
    }
    
    func sendCategoryValue(_ value: Int) {
        guard let url = URL(string: "http://127.0.0.1:5000/receive_values") else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestData: [String: Int] = [
            "values": value
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData)
            urlRequest.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                print("No data received: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let result = try? JSONDecoder().decode([String: Int].self, from: data) {
                DispatchQueue.main.async {
                    print("Server response:", result)
                }
            } else {
                print("Failed to decode server response")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IsisView()
    }
}

