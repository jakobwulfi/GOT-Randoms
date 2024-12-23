//
//  RandomGOTCharacters.swift
//  GOT
//
//  Created by dmu mac 31 on 18/09/2024.
//

import Foundation

struct GOTCharacter: Decodable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let title: String
    let family: String
    let image: String
    let imageUrl: String
}

