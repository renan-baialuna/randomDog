//
//  DogApi.swift
//  RandomDog
//
//  Created by Renan Baialuna on 05/03/21.
//

import Foundation
import UIKit


class DogApi {
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            default:
                return ""
            }
        }
    }
     
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void ) {
        let task2 = URLSession.shared.dataTask(with: url) { (data2, response , error) in
            guard let data = data2 else {
                completionHandler(nil, error)
                return
            }
            let newImage = UIImage(data: data)
            completionHandler(newImage, nil)
            
        }
        task2.resume()
    }
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void ) {
        
        let randomEndpoint = DogApi.Endpoint.randomImageForBreed(breed).url
        let task = URLSession.shared.dataTask(with: randomEndpoint) { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            
            completionHandler(imageData, nil)
             
        }
        task.resume()
    }
}
