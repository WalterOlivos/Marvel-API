//
//  ViewController.swift
//  marvel-api
//
//  Created by Walter Oliveira on 01/11/18.
//  Copyright © 2018 Walter Oliveira. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    private var character: Character?

    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let character = character else {
            fatalError("Please pass in a valid Character Object")
        }
        
        layoutCard(character: character)
    }
    
    @IBAction func sendId(_ sender: Any) {
        self.performSegue(withIdentifier: "Test", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let comicsViewController = segue.destination as? ComicsViewController {
            let viewModel = ComicsViewModel()
            viewModel.characterId = character!.id
            comicsViewController.viewModel = viewModel
        }
    }
    
}

extension InfoViewController {
    private func layoutCard(character: Character) {
        
        characterNameLabel.text = character.name
        
        characterDescriptionLabel.lineBreakMode = .byWordWrapping
        characterDescriptionLabel.text = character.description
        if character.description == "" {
            characterDescriptionLabel.text = "Description not avaliable"
        }
        characterDescriptionLabel.sizeToFit()
    
        characterImageView.kf.setImage(with: character.thumbnail.url)
        
    }
}

extension InfoViewController {
    static func instantiate(character: Character) -> InfoViewController {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CharacterViewController") as? InfoViewController else {
            fatalError("Unexpectedly failed getting CharacterViewController from Storyboard")
        }
        
        vc.character = character
        
        return vc
    }
}


