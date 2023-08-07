//
//  OpenAIService.swift
//  ChatGPTApp
//
//  Created by Chandana Murthy on 07.08.23.
//

import Foundation
import Alamofire
import Combine

class OpenAIService {
    let baseUrl = "https://api.openai.com/v1/"
    let model = "text-davinci-003"

    func sendMessage(message: String) -> AnyPublisher<OpenAIResponse, Error> {
        let body = OpenAICompletionsBody(model: self.model, prompt: message, temperature: 0.7, max_tokens: 500)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAPIKey)"
        ]
        return Future { [weak self] promise in
            guard let self else { return }
            AF.request(
                baseUrl + "completions",
                method: .post,
                parameters: body,
                encoder: .json,
                headers: headers).responseDecodable(of: OpenAIResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        promise(.success(result))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
