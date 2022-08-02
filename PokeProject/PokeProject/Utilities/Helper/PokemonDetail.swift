//
//  PokemonDetail.swift
//  PokeProject
//
//  Created by Aleyna on 31.07.2022.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    private var cache = CachedImage()
    @Published var image: UIImage?

    init(urlString: String) {
        if getImageCache(url: urlString) {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    return
                }
                
                self.image = image
                self.cache.setCache(url: urlString, image: image)
            }
        }
        task.resume()
    }
    
    func getImageCache(url: String) -> Bool {
        guard let image = cache.getCache(url: url) else {
            return false
        }
        self.image = image
        return true
    }
}

class CachedImage {
    var cache = NSCache<NSString, UIImage>()
    
    func getCache(url: String) -> UIImage? {
        return cache.object(forKey: NSString(string: url))
    }
    func setCache(url: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: url))
    }
}
