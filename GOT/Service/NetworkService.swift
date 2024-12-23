//
//  NetworkService.swift
//  GOT
//
//  Created by dmu mac 31 on 18/09/2024.
//

import SwiftUI

class NetworkService {
    static func getData(from url: URL) async -> Data? {
        let session = URLSession.shared
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else { return nil }
            if httpResponse.statusCode != 200 {
                fatalError("Noget gik galt! :(")
            }
            return data
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func fetchImage(from url: URL) async -> UIImage {
        var theImage: UIImage?
        let downloadTask = Task(priority: .background) { () -> UIImage in
            guard let rawData = await NetworkService.getData(from: url) else {
                return UIImage(systemName: "person")!
            }
            theImage = UIImage(data: rawData)
            if let theImage {
                return theImage
            } else {
                return UIImage(systemName: "person")!
            }
        }
        let result = await downloadTask.result
        return result.get()
    }
}
