//
//  PokeCell.swift
//  Pokedex
//
//  Created by David Santos on 08/05/17.
//  Copyright © 2017 dscode. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.02
    }
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.nameLbl.text = self.pokemon.name
        self.thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
