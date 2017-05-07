//
//  Pokemon.swift
//  Pokedex
//
//  Created by David Santos on 07/05/17.
//  Copyright © 2017 dscode. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _pokedexId : String!
    private var _name: String!
    
    var pokedexId : String {
        return _pokedexId
    }
    
    var name : String {
        return _name
    }
    
    init(name: String, pokedexId: String) {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
