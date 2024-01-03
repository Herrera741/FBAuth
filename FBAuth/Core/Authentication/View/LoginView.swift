//
//  LoginView.swift
//  FBAuth
//
//  Created by Sergio Herrera on 12/26/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthVM
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    // image
                    Image(systemName: "message.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.green)
                        .padding(.vertical, 30)
                    
                    // form fields
                    VStack(spacing: 25) {
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                        .textInputAutocapitalization(.never)
                        
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: true)
                    }
                    .padding(.horizontal)
                    .padding(.top, 15)
                    
                    // signin button
                    Button {
                        Task {
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundStyle(.white)
                        .frame(width: abs(geo.size.width - 30), height: 50)
                    }
                    .background(.blue)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .padding(.top, 25)
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    
                    Spacer()
                    
                    // signup button
                    NavigationLink {
                        RegistrationView()
                            .toolbar(.hidden, for: .navigationBar)
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                            Text("Sign Up")
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 15))
                    } // end NavLink
                } // end VStack
            } // end GeoReader
        } // end NavStack
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        // check if email is not empty, has '@' symbol
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
