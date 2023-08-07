//
//  IncompatibleView.swift
//  ChatGPTApp
//
//  Created by Chandana Murthy on 29.07.23.
//

import SwiftUI

struct IncompatibleView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()

            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 48))
                    .foregroundStyle(Color.yellow)
                    .padding(.bottom, 8)

                Text("The OpenAI API key is not provided.\nPlease add a key in the Constants file")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .foregroundStyle(Color.white)
            }

        }
    }
}


struct IncompatibleView_Previews: PreviewProvider {
    static var previews: some View {
        IncompatibleView()
    }
}
