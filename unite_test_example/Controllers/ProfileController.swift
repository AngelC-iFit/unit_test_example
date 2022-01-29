//
//  ProfileController.swift
//  unite_test_example
//
//  Created by Angel Contreras on 1/27/22.
//

import Foundation

class ProfileController {
    private let defaultURL = "https://teamtreehouse.com/matthew.json"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchProfileWithURL(_ url: String? = nil, completion: @escaping (Profile?) -> Void) {
        
        guard let requestUrl = URL(string: url ?? defaultURL) else {
            completion(nil)
            return }
        
        let task = session.dataTask(with: requestUrl) { [weak self] data, response, error in
            
            var fetchedProfile: Profile?
            defer {
                DispatchQueue.main.async {
                    completion(fetchedProfile)  
                }
            }
            guard let strongSelf = self else { return }
            guard let data = data else { return }
                
            do {
                fetchedProfile = try strongSelf.decoder.decode(Profile.self, from: data)
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container,
                        debugDescription: "Cannot decode date string \(dateString)")
        })
        
        return decoder
    }
}
