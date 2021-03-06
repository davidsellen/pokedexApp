//
//  Pokemon.swift
//  Pokedex
//
//  Created by David Santos on 07/05/17.
//  Copyright © 2017 dscode. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _pokedexId : Int!
    private var _name: String!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _currentEvolutionName: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _evolution: String!
    private var _pokemonURL: String!
    
    var pokedexId : Int {
        return _pokedexId
    }
    
    var name : String {
        return _name
    }
    
    var description: String {
        get {
            if _description == nil {
                _description = ""
            }
            return _description
        }
    }

    var type: String {
        get {
            if _type == nil {
                _type = ""
            }
            return _type
        }
    }

    var defense: String {
        get {
            if _defense == nil {
                _defense = ""
            }
            return _defense
        }
    }

    var height: String {
        get {
            if _height == nil {
                _height = ""
            }
            return _height
        }
    }

    var weight: String {
        get {
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }
    }

    var attack: String {
        get {
            if _attack == nil {
                _attack = ""
            }
            return _attack
        }
    }

    var currentEvolutionName: String {
        get {
            if _currentEvolutionName == nil {
                _currentEvolutionName = ""
            }
            return _currentEvolutionName
        }
    }

    var nextEvolutionTxt: String {
        get {
            if _nextEvolutionTxt == nil {
                _nextEvolutionTxt = ""
            }
            return _nextEvolutionTxt
        }
    }

    
    var nextEvolutionName: String {
        get {
            if _nextEvolutionName == nil {
                _nextEvolutionName = ""
            }
            return _nextEvolutionName
        }
    }
    
    var nextEvolutionId: String {
        get {
            if _nextEvolutionId == nil {
                _nextEvolutionId = ""
            }
            return _nextEvolutionId
        }
    }

    var nextEvolutionLevel: String {
        get {
            if _nextEvolutionLevel == nil {
                _nextEvolutionLevel = ""
            }
            return _nextEvolutionLevel
        }
    }
    
    var evolution: String {
        get {
            if _evolution == nil {
                _evolution = ""
            }
            return _evolution
        }
    }

    init(name: String, pokedexId: Int) {
        self._name = name.capitalized
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId!)/"
    }
    
    func downloadPokemonDetails(complete: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, Any> {
               
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    var typeArray = [String]()
                    for type in types {
                        typeArray.append(type["name"]!.capitalized)
                    }
                    self._type = typeArray.joined(separator: "/")
                }
                
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>] , descArray.count > 0 {
                    
                    if let url = descArray[0]["resource_uri"] {
                        
                        Alamofire.request("\(URL_BASE)\(url)").responseJSON { descResponse in
                            
                            if let descDict = descResponse.result.value as? Dictionary<String, Any> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                }
                            }
                            complete()
                        }
                        
                    }
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, Any>] , evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                    
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = nextEvoId
                             
                                if let lvlExist = evolutions[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                            
                        }
                    }
                    
                }
            }
            
            complete()
        }
        
    }
    
}
