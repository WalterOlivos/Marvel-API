//
//  CharacterViewController.swift
//  marvel-api
//
//  Created by Walter Oliveira on 05/11/18.
//  Copyright © 2018 Walter Oliveira. All rights reserved.
//

import Foundation
import UIKit
import Moya

class CharacterViewController: UIViewController {
    
    private var viewModel = CharacterViewModel()
    
    private var state: State = .loading {
        didSet {
            stateSwitch()
        }
    }
    
    private func stateSwitch() {
        switch state {
        case .ready:
            viewMessage.isHidden = true
            tableCharacters.isHidden = false
            tableCharacters.reloadData()
        case .loading:
            tableCharacters.isHidden = true
            viewMessage.isHidden = false
            labelStatusMessage.text = "Getting characters..."
        case .error:
            tableCharacters.isHidden = true
            viewMessage.isHidden = false
            labelStatusMessage.text =   """
            Something went wrong!
            Try again later.
            """
        }
    }
    
    @IBOutlet weak var tableCharacters: UITableView!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var labelStatusMessage: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCharacters.delegate = self
        tableCharacters.dataSource = self
        state = .loading
        
        loadMoreCharacters()
    }
    
    func loadMoreCharacters() {
        viewModel.loadMoreCharacters() { error in
            if error {
                self.state = .error
            } else {
                self.state = .ready
            }
        }
    }
}

extension CharacterViewController {
    enum State {
        case loading
        case ready
        case error
    }
}

extension CharacterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as? CharacterCell ?? CharacterCell()
        
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: self.tableCharacters.frame.width, height: 44)
        self.tableCharacters.tableFooterView = spinner

        cell.configure(with: viewModel.characters[indexPath.row])
        
        
        if (indexPath.row == viewModel.characters.count - 1) {
            loadMoreCharacters()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let characterVC = InfoViewController.instantiate(character: viewModel.characters[indexPath.row])
        navigationController?.pushViewController(characterVC, animated: true)
    }
}
