//
//  ContentView.swift
//  ChatbotOne
//
//  Created by Adam Daris Ryadhi on 18/09/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    
    let model = GenerativeModel(
        name: "gemini-pro",
        apiKey: "Your API Key")
    
    @State var output: String = ""
    @State var input: String = ""
    
    var body: some View {
        VStack{
            ScrollView{
                Text(output)
            }
            HStack{
                TextField("Ask me anything", text: $input)
                    .textFieldStyle(.roundedBorder)
                
                Spacer()
                
                Button(action: {
                    if input != "" {
                        Task {
                            let response = try await model.generateContent(input)
                            if let text = response.text {
                                output = text
                                input = ""
                            }
                        }
                    }
                    
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title)
                })
            }
        }
        .padding()
    }
}
#Preview {
    ContentView()
}
