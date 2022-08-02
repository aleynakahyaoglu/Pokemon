//
//  Network.swift
//  PokeProject
//
//  Created by Aleyna on 2.08.2022.
//

import Foundation


struct Network {
    static let shared = Network()
   
    
    func networkReq(id: Int, success : @escaping (Pokemon) -> ()) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let decoded = try? decoder.decode(Pokemon.self, from: data) {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        
                        success(decoded)
                    }
                }
            }
        }.resume()
    }
        
        
        
    
}
