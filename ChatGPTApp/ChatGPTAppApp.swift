//
//  ChatGPTAppApp.swift
//  ChatGPTApp
//
//  Created by Chandana Murthy on 19.12.22.
//

import SwiftUI

@main
struct ChatGPTAppApp: App {
    var body: some Scene {
        WindowGroup {
            if Constants.openAPIKey.isEmpty {
                IncompatibleView()
            } else {
                ChatView()
            }
        }
    }
}
