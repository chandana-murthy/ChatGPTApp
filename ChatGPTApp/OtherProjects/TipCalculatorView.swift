//
//  TipCalculatorView.swift
//  ChatGPTApp
//
//  Created by Chandana Murthy on 21.03.23.
//

import SwiftUI

struct TipCalculatorView: View {
    @State var totalAmount: String = ""
    @State var tipPercent: Float = 0

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "eurosign.circle.fill")
                    .foregroundColor(.blue)
                    .font(.largeTitle)

                Text("Tip Calculator")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }

            HStack {
                Text("€")
                    .padding(.leading)
                TextField(
                    "€",
                    text: $totalAmount,
                    prompt: Text("Enter the total bill amount")
                )
                .keyboardType(.decimalPad)
                .padding()
                .border(Color.gray.opacity(0.4))
                .padding(.trailing)
            }

            HStack {
                Slider(value: $tipPercent, in: 0...50, step: 2)
                    .padding()
                    .padding(.leading, 24)

                Text("\(String(format: "%.0f", tipPercent))%")
                    .padding(.trailing, 24)
            }

            Text("Tip Amount: €\(getTipValue())")
        }
    }

    func getTipValue() -> String {
        let amount = (Float(totalAmount) ?? 0) * tipPercent / 100
        return String(format: "%.2f", amount)
    }
}

struct TipCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        TipCalculatorView()
    }
}
