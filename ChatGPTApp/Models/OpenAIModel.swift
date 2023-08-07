//
//  OpenAICompletionsBody.swift
//  ChatGPTApp
//
//  Created by Chandana Murthy on 07.08.23.
//

import Foundation

struct OpenAICompletionsBody: Codable {
    let model: String
    let prompt: String
    let temperature: Float?
    let max_tokens: Int?
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: Codable {
    case system
    case user
    case assistant
}

struct OpenAIResponse: Codable {
    let id: String
    let choices: [CompletionOption]
}

struct CompletionOption: Codable {
    let text: String
}
