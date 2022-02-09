//
//  ComicCell.swift
//  marvel-api
//
//  Created by Walter Oliveira on 13/11/18.
//  Copyright © 2018 Walter Oliveira. All rights reserved.
//

import UIKit
import Kingfisher

class ComicCell: UITableViewCell {
    static let reuseIdentifier = "ComicCell"
    
    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    public func configure(with comic: Comic) {
        
        labelTitle.text = comic.title
        
        imageThumbnail.kf.setImage(with: comic.thumbnail.url)
        
    }
}
