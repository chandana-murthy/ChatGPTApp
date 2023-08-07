//
//  ContentView.swift
//  ChatGPTApp
//
//  Created by Chandana Murthy on 19.12.22.
//

import SwiftUI
import Combine

struct ChatView: View {
    @State var text: String = ""
    @State var showError = false
    @State var error: Error?
    var viewModel = ChatViewModel()

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()

            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages, id: \.id) { message in
                            messageView(message: message)
                        }
                    }
                    .padding()
                }

                HStack {
                    textField

                    sendButton
                }
                .padding(16)

            }
            .alert("Error!", isPresented: $showError) {
                Button("Okay") {  }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "Please check if your OpenAI free trial is valid. If not, a new account is needed")
            }
        }
    }

    var textField: some View {
        TextField("Enter a message...", text: $text) {
            sendMessage()
        }
        .padding()
        .background(.white.opacity(0.1))
        .cornerRadius(12)
    }

    var sendButton: some View {
        Button {
            sendMessage()
        } label: {
            Text("Send")
                .foregroundColor(.white)
                .padding()
                .background(Color("GptColor") )
                .cornerRadius(12)
        }
    }

    func messageView(message: ChatMessage) -> some View {
        HStack {
            if message.sender == .currentUser {
                Spacer()
            }
            VStack(alignment: message.sender == .currentUser ? .trailing : .leading) {
                Text(message.content)
                    .foregroundColor(.white)
                    .padding()
                    .background(message.sender == .currentUser ? Color("GptColor") : .white.opacity(0.2))
                    .cornerRadius(16)

                Text(message.dateCreated.formatted())
                    .font(.caption2)
                    .foregroundStyle(Color.gray)
            }

            if message.sender == .chatGpt {
                Spacer()
            }
        }
    }

    func sendMessage() {
        viewModel.sendMessage(messageText: text) { success in
            if !success {
                showError = true
            } else {
                text = ""
            }
        }
    }
}
