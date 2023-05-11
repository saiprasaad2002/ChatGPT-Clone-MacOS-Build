//
//  ContentView.swift
//  ChatGPT macos
//
//  Created by RITSJC-004 on 11/04/23.
//

import SwiftUI
import AppKit
import OpenAISwift

struct ContentView: View {
    
    @State private var search: String = ""
    
    let openAI = OpenAISwift(authToken: "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")
    
    @State private var responses: [String] = []
    
    private var isFormValid: Bool {
        !search.isEmpty
    }
    
    private func performSearch() {
        responses.append("You: \(search)")
        
        openAI.sendCompletion(with: search,maxTokens: 500) { result in switch result {
        case .success(let success):
            let response = "ChatGPT: \(success.choices?.first?.text ?? "")"
            responses.append(response)
        case .failure(let failure):
            print(failure.localizedDescription)
        }}
        
    }
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $search)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    performSearch()
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title)
                }.buttonStyle(.borderless)
                    .disabled(!isFormValid)
            }
            
            
            
            List(responses, id: \.self) { response in
                Text(response)
               
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
