//
//  CharacterCell.swift
//  marvel-api
//
//  Created by Walter Oliveira on 05/11/18.
//  Copyright © 2018 Walter Oliveira. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    static let reuseIdentifier = "CharacterCell"

    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    
    public func configure(with character: Character) {
        
        labelName.text = character.name
        
        imageThumbnail.kf.setImage(with: character.thumbnail.url)

    }
}
