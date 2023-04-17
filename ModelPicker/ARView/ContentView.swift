//
//  ContentView.swift
//  ModelPicker
//
//  Created by Fernando Fernandes on 24.07.20.
//
import SwiftUI

struct ContentView: View {

    // MARK: - Properties
    @State private var isPlacementEnabled = false
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?
    @State private var shouldRemoveAllModels = false

    private var models: [Model] = {
        let fileManager = FileManager.default
        guard let path = Bundle.main.resourcePath,
              let files = try? fileManager.contentsOfDirectory(atPath: path) else {
            return []
        }
        return files
            .filter { $0.hasSuffix(".usdz") }
            .compactMap { $0.replacingOccurrences(of: ".usdz", with: "") }
            .compactMap { Model(modelName: $0 ) }
    }()

    // MARK: Body
    
    var body: some View {
        VStack{
            Button(role: .destructive) {
                           shouldRemoveAllModels = true
                       } label: {
                           HStack {
                               Image(systemName: "trash")
                               Text("Clear the scene")
                           }
                           .foregroundColor(.white) // set the text and icon color to white
                             .frame(maxWidth: 200) // set the HStack to occupy the full width
                             .padding() // add some padding around the content
                             .background(Color.red) // set the background color to red
                             .cornerRadius(25) // round the corners of the button
                       }
            ZStack(alignment: .bottom) {
                ARViewRepresentable(
                    modelConfirmedForPlacement: $modelConfirmedForPlacement,
                    shouldRemoveAllModels: $shouldRemoveAllModels
                )

                if isPlacementEnabled {
                    PlacementButtonView(
                        isPlacementEnabled: $isPlacementEnabled,
                        selectedModel: $selectedModel,
                        modelConfirmedForPlacement: $modelConfirmedForPlacement
                    )
                } else {
                    ModelPickerView(
                        isPlacementEnabled: $isPlacementEnabled,
                        selectedModel: $selectedModel,
                        models: models
                    )
                }
            }
        }
    }
    
}

// MARK: - Preview
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
//
