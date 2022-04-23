//
//  DiscoverViewController.swift
//  expchef
//
//  Created by Colin To on 2022-03-11.
//

import UIKit

class DiscoverViewController: UIViewController{

//    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!

    let networker = NetworkAPIManager.shared
    
    var posts: [PostAPI] = []
    
    // Download the data from the Internet or FireBase or Realm
    var items = Item.fetchItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We have to make sure self is weak because if this controller is going to go out of memory
        // while network request was happening, networkAPImanager would keep this viewcontroller
        // in memory if it had a strong reference.
        // networkmanager can't keep a reference anymore if it goes out of memory
        
        networker.posts(query: "happy") { [weak self] posts, error in
            if let error = error {
                print("error", error)
                return
            }
            
            self?.posts = posts!
            
            // Reload the tableview on the main cue because its a UI update
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        
        // Set friend carousel
        let cellNib = UINib(nibName: "DiscoverWebTableViewCell", bundle: nil)
        let friendNib = UINib(nibName: "DiscoverFriendTableViewCell", bundle: nil)
        tableView.register(friendNib, forCellReuseIdentifier: "DiscoverFriendTableViewCell")
        tableView.register(cellNib, forCellReuseIdentifier: "webCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        // Create navbar
        configureItems()
    }
    
    private func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil)
    }
    
    @IBAction func discoveritemPressed(_ sender: Any) {
                let recipeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.recipeViewController)
                
                self.view.window?.rootViewController = recipeViewController
                self.view.window?.makeKeyAndVisible()
        }
}

// Web Layout
extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = CGFloat()
        
        if indexPath.row < 1{
            cellHeight = 225
        }
        else{
            cellHeight = 150
        }
        
        return cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(posts)
//        return posts.count
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < 1 {
            // Show collection view
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverFriendTableViewCell", for: indexPath) as! DiscoverFriendTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "webCell", for: indexPath) as! DiscoverWebTableViewCell
        return cell
    }
    
    // If an item in any cell is selected, pass data to recipe view controller and show that
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let recipeview = storyboard?.instantiateViewController(identifier: "RecipeVC") as? RecipeViewController {
            // Use this as the image data input
//            recipeview.imageItem = UIImage(named: items[indexPath.row])
            
            // THIS WAS THE PREVIOUS WORKING TITLE
            recipeview.fname = items[indexPath.row-1].title
            
            // Assign Title Data from From API
//            let post = posts[indexPath.item]
//            recipeview.fname = post.title!
            
//            print(post)
            // From API
            
            self.navigationController?.pushViewController(recipeview, animated: true)
        }
    }
}
