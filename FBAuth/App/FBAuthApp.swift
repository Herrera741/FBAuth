//
//  FBAuthApp.swift
//  FBAuth
//
//  Created by Sergio Herrera on 12/26/23.
//

import SwiftUI
import Firebase

@main
struct FBAuthApp: App {
    @StateObject var viewModel = AuthVM()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
