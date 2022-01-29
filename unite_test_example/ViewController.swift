//
//  ViewController.swift
//  unite_test_example
//
//  Created by Angel Contreras on 1/27/22.
//

import UIKit

class ViewController: UITableViewController {
    
    private let cellID = "profile-cell"
    
    var profile: Profile? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BadgeCell.self, forCellReuseIdentifier: BadgeCell.cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile?.badges.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BadgeCell.cellID, for: indexPath) as? BadgeCell

        if let badge = profile?.badges[indexPath.row] {
            let badgeViewModel = BadgeCellViewModel(badge)
            cell?.viewModel = badgeViewModel
        }
        
        return cell ?? UITableViewCell()
    }
    
    @IBAction func getBadgesButtonPressed(_ sender: UIBarButtonItem) {
        ProfileController().fetchProfileWithURL { [weak self] profile in
            if let strongSelf = self {
                strongSelf.profile = profile
            }
        }
    }
}

