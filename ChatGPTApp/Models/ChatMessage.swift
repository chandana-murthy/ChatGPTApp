//
//  ChatMessage.swift
//  ChatGPTApp
//
//  Created by Chandana Murthy on 07.08.23.
//

import Foundation

struct ChatMessage {
    let id: String
    let content: String
    let dateCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case currentUser
    case chatGpt
}

