//
//  ContentView.swift
//  FBAuth
//
//  Created by Sergio Herrera on 12/26/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthVM
    
    var body: some View {
        Group {
            // user already logged in
            if viewModel.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        } // end Group
    }
}

#Preview {
    ContentView()
}
