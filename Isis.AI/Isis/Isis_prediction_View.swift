import SwiftUI

struct QuestionView: View {
    
    @State private var currentQuestionIndex: Int = 0
    @State private var questionsWithIndex: [(index: Int, question: String)] = []
    @State private var userResponses: [Int?] = [] {
        didSet {
            if userResponses.count == questionsWithIndex.count {
                sendUserResponses()
            }
        }
    }
    @State private var predictionResult: String = ""
    @State private var isPredictionVisible: Bool = false
    @State private var isLoading: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                if !isPredictionVisible {
                    if isLoading {
                        VStack {
                            Text("Veuillez patienter..")
                                .padding()
                                .font(.custom("NeutralFace", size: 25))
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                                .scaleEffect(1.5)
                                .padding()
                            
                        }
                        .frame(width: 360, height: 200)
                        .cornerRadius(10)
                        .padding(.top,200)
                    } else if !questionsWithIndex.isEmpty {
                        VStack(spacing: 15) {
                            Text(questionsWithIndex[currentQuestionIndex].question)
                                .padding(.bottom)
                            
                            HStack(spacing: 10) {
                                Button(action: {
                                    userResponses.append(0)
                                    nextQuestion()
                                }) {
                                    Text("Non")
                                        .padding()
                                        .frame(width: 150, height: 40)
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(10)
                                        .shadow(radius: 3)
                                }
                                .disabled(userResponses.indices.contains(currentQuestionIndex))
                                
                                Button(action: {
                                    userResponses.append(1)
                                    nextQuestion()
                                }) {
                                    Text("Oui")
                                        .padding()
                                        .frame(width: 150, height: 40)
                                        .background(Color.gradient2)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                }
                                .disabled(userResponses.indices.contains(currentQuestionIndex))
                            }
                        }
                        .frame(width: 360)
                        .padding(.top,200)
                    }
                } else {
                    Text("Prediction Result:")
                    Text(predictionResult)
                        .padding()
                        .multilineTextAlignment(.center)
                }
            }
            .padding()
            .onAppear {
                isLoading = true
                getQuestions()
            }
        }
    }
    
    func getQuestions() {
        guard let url = URL(string: "http://127.0.0.1:5000/question") else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                print("No data received: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let questions = try? JSONDecoder().decode([String].self, from: data) {
                DispatchQueue.main.async {
                    self.questionsWithIndex = questions.enumerated().map { (index, question) in
                        return (index, question)
                    }
                    self.isLoading = false
                }
            } else {
                print("Failed to decode questions")
            }
        }.resume()
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex >= questionsWithIndex.count {
            currentQuestionIndex = questionsWithIndex.count - 1
            sendUserResponses()
        }
    }
    
    func sendUserResponses() {
        guard let url = URL(string: "http://127.0.0.1:5000/prediction") else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestData: [String: Any] = [
            "responses": userResponses.compactMap { $0 }
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
            
            if let result = try? JSONDecoder().decode([String: String].self, from: data) {
                DispatchQueue.main.async {
                    self.predictionResult = result["prediction"] ?? "Unknown"
                    self.isPredictionVisible = true
                }
            } else {
                print("Failed to decode prediction result")
            }
        }.resume()
    }
}

struct Isis_prediction_View: View {
    var body: some View {
        QuestionView()
    }
}

struct Provider_response: PreviewProvider {
    static var previews: some View {
        Isis_prediction_View()
    }
}

