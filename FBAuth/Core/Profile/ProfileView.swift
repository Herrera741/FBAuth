//
//  ProfileView.swift
//  FBAuth
//
//  Created by Sergio Herrera on 12/26/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthVM
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 75, height: 75)
                            .background(Color(.systemGray3))
                            .clipShape(
                                Circle()
                        )
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        } // end VStack
                    } // end HStack
                }
                
                Section("General") {
                    
                    HStack {
                        SettingsRowView(imageName: "gear",
                                        title: "Version",
                                        tintColor: .gray)
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                
                Section("Account") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out",
                                        tintColor: .red)
                    }
                    
                    Button {
                        print("Delete account ...")
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Delete Account",
                                        tintColor: .red)
                    }
                }
            } // end List
        } // end if statement
    }
}

#Preview {
    ProfileView()
}

