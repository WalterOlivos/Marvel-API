//
//  ComicsViewController.swift
//  marvel-api
//
//  Created by Walter Oliveira on 13/11/18.
//  Copyright © 2018 Walter Oliveira. All rights reserved.
//

import Foundation
import UIKit
import Moya

class ComicsViewController: UIViewController {
    
    var viewModel = ComicsViewModel()
    
    private var state: State = .loading {
        didSet {
            stateSwitch()
        }
    }
    
    private func stateSwitch() {
        switch state {
        case .ready:
            viewMessage.isHidden = true
            tableComics.isHidden = false
            tableComics.reloadData()
        case .loading:
            tableComics.isHidden = true
            viewMessage.isHidden = false
            labelStatusMessage.text = "Getting comics..."
        case .error:
            tableComics.isHidden = true
            viewMessage.isHidden = false
            labelStatusMessage.text = """
            Something went wrong!
            Try again later.
            """
        }
    }
    
    @IBOutlet weak var tableComics: UITableView!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var labelStatusMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableComics.delegate = self
        tableComics.dataSource = self
        state = .loading
        
        loadMoreComics()
        
    }
    
    func loadMoreComics() {
        viewModel.loadMoreComics() { error in
            if error {
                self.state = .error
            } else {
                self.state = .ready
            }
        }
    }
}

extension ComicsViewController {
    enum State{
        case loading
        case ready
        case error
    }
}


extension ComicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicCell.reuseIdentifier, for: indexPath) as? ComicCell ?? ComicCell()

        cell.configure(with: viewModel.comics[indexPath.row])
        
        if (indexPath.row == viewModel.comics.count - 1
                && viewModel.currentOffset < viewModel.totalComics) {
            loadMoreComics()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
