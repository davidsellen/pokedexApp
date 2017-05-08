//
//  Pokemon.swift
//  Pokedex
//
//  Created by David Santos on 07/05/17.
//  Copyright © 2017 dscode. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _pokedexId : Int!
    private var _name: String!
    
    var pokedexId : Int {
        return _pokedexId
    }
    
    var name : String {
        return _name
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name.capitalized
        self._pokedexId = pokedexId
    }
    
}
