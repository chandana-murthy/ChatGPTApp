//
//  ChatViewModel.swift
//  ChatGPTApp
//
//  Created by Chandana Murthy on 07.08.23.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [ChatMessage(
        id: UUID().uuidString,
        content: "Hi! How can I help you?",
        dateCreated: Date(),
        sender: .chatGpt)]
    @Published var error: Error?
    let openAIService = OpenAIService()
    var cancellables = Set<AnyCancellable>()

    func sendMessage(messageText: String, completion: @escaping ((Bool) -> Void)) {
        let myMessage = ChatMessage(
            id: UUID().uuidString,
            content: messageText,
            dateCreated: Date(),
            sender: .currentUser
        )
        messages.append(myMessage)
        openAIService.sendMessage(message: messageText).sink { [weak self] response in
            switch response {
            case .finished:
                completion(true)
            case .failure(let error):
                self?.error = error
                completion(false)
            }
        } receiveValue: { [weak self] response in
            guard let messageReceived = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else {
                return
            }
            let gptMessage = ChatMessage(id: response.id, content: messageReceived, dateCreated: Date(), sender: .chatGpt)
            self?.messages.append(gptMessage)
            completion(true)
        }
        .store(in: &cancellables)
    }
}
