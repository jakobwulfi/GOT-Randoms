//
//  StateController.swift
//  GOT
//
//  Created by dmu mac 31 on 18/09/2024.
//

import SwiftUI

@Observable
class StateController {
    var characters: [GOTCharacter] = []
    var urlImageMap: [String: UIImage] = [:]
    
    init() {
        guard let GOTCharactersURL = URL(string: "https://thronesapi.com/api/v2/Characters") else {return}
        fetchUsers(from: GOTCharactersURL)
    }
    
    private func fetchUsers(from url: URL) {
        Task(priority: .low) {
            guard let rawCharacterData = await NetworkService.getData(from: url) else {return}
            let decoder = JSONDecoder()
            do {
                let jsonResult = try decoder.decode([GOTCharacter].self, from: rawCharacterData)
                Task {@MainActor in
                    self.characters = jsonResult
                    await fetchImages()
                }
            } catch {
                fatalError("Konverteringen gik ad H til")
            }
        }
    }
    
    private func fetchImages() async {
        await withTaskGroup(of: Void.self) { group in
            characters.forEach { character in
                group.addTask {
                    let characterImage = await NetworkService.fetchImage(from: URL(string: character.imageUrl)!)
                    self.urlImageMap.updateValue(characterImage, forKey: character.imageUrl)
                }
            }
        }
    }
}

