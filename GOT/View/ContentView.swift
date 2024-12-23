//
//  ContentView.swift
//  GOT
//
//  Created by dmu mac 31 on 18/09/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(StateController.self) var controller: StateController
    var body: some View {
        List(controller.characters) { character in
            HStack {
                if let image = controller.urlImageMap[character.imageUrl] {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40.0)
                        .cornerRadius(40)
                } else {
                    ProgressView()
                }
                Text(character.fullName)
            }
        }
    }
}

#Preview {
    ContentView().environment(StateController())
}
