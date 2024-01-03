//
//  User.swift
//  FBAuth
//
//  Created by Sergio Herrera on 12/26/23.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var fullname: String
    var email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: UUID().uuidString, fullname: "Test User", email: "tuser@gmail.com")
}
