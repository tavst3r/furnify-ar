//
//  ClearButtonView.swift
//  ModelPicker-test-2
//
//  Created by Tavi Diaconu on 11.04.2023.
//

import SwiftUI

struct ClearButtonView: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "trash")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .clipShape(Circle())
        }
    }
}
