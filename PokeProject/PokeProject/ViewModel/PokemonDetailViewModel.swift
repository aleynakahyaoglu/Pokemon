//
//  PokemonDetailViewModel.swift
//  PokeProject
//
//  Created by Aleyna on 31.07.2022.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon = Pokemon()
    @Published var isLoaded = false
    func fetchPokemonDetail(pokemonId id: Int) {
        Network.shared.networkReq(id: id) { pokemon in
            self.pokemon = pokemon
            self.isLoaded = true
        }
    }
}
