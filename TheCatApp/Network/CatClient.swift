//
//  CatClient.swift
//  TheCatApp
//
//  Created by Nathan Novacek on 10/12/20.
//

import Foundation

class CatClient {
    
    static private let apiKey = "8a2d4e04-7f56-4f4c-ad37-799232b62642"
    static private let base = "https://api.thecatapi.com/v1"
    
    enum Endpoint {
        case base
        case breeds
        case categories
        case votes
        case favorites
        case images
        
        var stringValue: String {
            switch self {
            case .base: return CatClient.base
            case .breeds: return CatClient.base + "/breeds"
            case .categories: return CatClient.base + "/categories"
            case .votes: return CatClient.base + "/votes"
            case .favorites: return CatClient.base + "/favourites"
            case .images: return CatClient.base + "/images"
            }
        }
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
    }
    
}

 // ------------------------------------------------------------------------------
 // MARK: GET methods
extension CatClient {

    class func getAllBreeds(completionHandler: @escaping([Breed]?, Error?) -> Void) {
        taskForGETRequest(url: Endpoint.breeds.url, responseType: [Breed]?.self) { (response, error) in
            if let response = response {
                completionHandler(response, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    class func getImageByBreedId(breedId: String, completionHandler: @escaping([Image]?, Error?) -> Void) {
        guard let url = URL(string: Endpoint.images.url.absoluteString + "/search?breed_id=\(breedId)") else { return }
        taskForGETRequest(url: url, responseType: [Image]?.self) { (response, error) in
            if let response = response {
                completionHandler(response, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }

}

// ------------------------------------------------------------------------------
// MARK: Generic methods for HTTP requests
extension CatClient {

    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completionHandler: @escaping(ResponseType?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }

            do {
                let responseObject = try JSONDecoder().decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(responseObject, nil)
                }
                return
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
        }
        task.resume()
    }

}
