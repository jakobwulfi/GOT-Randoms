//
//  GOTApp.swift
//  GOT
//
//  Created by dmu mac 31 on 18/09/2024.
//

import SwiftUI

@main
struct GOTApp: App {
    var body: some Scene {
        @State var controller = StateController()
        WindowGroup {
            ContentView().environment(controller)
        }
    }
}
