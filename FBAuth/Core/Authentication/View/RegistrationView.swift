//
//  RegistrationView.swift
//  FBAuth
//
//  Created by Sergio Herrera on 12/26/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthVM
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(systemName: "message.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.green)
                    .padding(.vertical, 30)
                
                VStack(spacing: 25) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .textInputAutocapitalization(.never)
                    
                    InputView(text: $fullname,
                              title: "Full Name",
                              placeholder: "Enter your name")
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $confirmPassword,
                                  title: "Confirm Password",
                                  placeholder: "Confirm your password",
                                  isSecureField: true)
                        
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            let passwordMatch = password == confirmPassword
                            Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(passwordMatch ? .green : .red)
                        }
                    } // end ZStack
                } // end VStack
                .padding(.horizontal)
                .padding(.top, 15)
                
                Button {
                    Task {
                        try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                    }
                } label: {
                    HStack {
                        Text("SIGN UP")
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
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Sign In")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 15))
                }
            } // end VStack
        } // end GeoReader
    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        // check if email is not empty, has '@' symbol
        return !email.isEmpty
        && email.contains("@")
        && !fullname.isEmpty
        && fullname.count > 5
        && !password.isEmpty
        && password.count > 5
        && password == confirmPassword
    }
}

#Preview {
    RegistrationView()
}
