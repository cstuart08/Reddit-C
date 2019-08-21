//
//  PostListTableViewController.swift
//  Reddit-C
//
//  Created by Apps on 8/21/19.
//  Copyright © 2019 Apps. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController, UISearchBarDelegate {
    
    private let postListCellID = "postCell"

    @IBOutlet weak var searchBar: UISearchBar!
    
    var posts = [CMSPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = self.searchBar.text, !searchTerm.isEmpty else { return }
        searchBar.resignFirstResponder()
        
        let searchSTR = searchTerm.replacingOccurrences(of: " ", with: "_")
        
        CMSPostController.shared().searchForPost(withSearchTerm: searchSTR) { [weak self] (posts, error) in
            guard let self = self else { return }
            self.posts = posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchBar.text = ""
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postListCellID, for: indexPath)

        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = "Ups \(post.ups) 👍 Comments \(post.commentCount)"

        return cell
    }
}
