//
//  Pokemon.swift
//  PokeProject
//
//  Created by Aleyna on 31.07.2022.
//


import Foundation

struct Pokemon: Decodable {
    var name = ""
    var height = 0
    var weight = 0
    var baseExperience = 0
    var types = [Types]()
    var stats = [Stats]()
    var sprites = Sprites()
    
    var formattedName: String {
        if name.count != 0 {
            return String(Array(name)[0].uppercased() + name.dropFirst())
        }
        return ""
    }
}

struct Stats: Decodable {
    struct Stat: Decodable {
        var name = ""
    }
    
    var baseStat = 0
    var stat: Stat
    
    
 var formattedName: String {
        if stat.name.count != 0 {
            let removedHypens = stat.name.replacingOccurrences(of: "-", with: " ").capitalized
            return removedHypens.replacingOccurrences(of: "Special", with: "Sp. ")
                  .replacingOccurrences(of: "Attack", with: "Atk")
                  .replacingOccurrences(of: "Defense", with: "Def")
        }
        return ""
    }
    
    var maximumStat: Int {
        if stat.name == "hp" {
            return baseStat * 2 + 404
        } else {
            return Int(Double(baseStat * 2 + 99) * 1.1)
        }
    }
}

struct Types: Decodable {
    struct `Type`: Decodable {
        var name = ""
    }
    
    var type: Type
}

struct Sprites: Decodable {
    var frontDefault = ""
    var backDefault = ""
}
