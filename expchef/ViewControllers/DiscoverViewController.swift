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

    
    // Download the data from the Internet or FireBase or Realm
    var items = Item.fetchItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading view
        
        // URL (endpoint)
        let url = URL(string: "https://api.spoonacular.com/recipes")
        
        guard url != nil else {
            print("Error creating url object")
            return
        }
        
        // URL Request / 1 hour of cache, then delete data aftewards
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        // Specify the headeer
        let header = [
            "apiKey": "7ab2d544461d46f4ac0dfaacda9c2371",
            "content-type": "application/json"]
        
        request.allHTTPHeaderFields = header
        
        // Specify the body
        let jsonObj = [""]
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: jsonObj, options: .fragmentsAllowed)
            
            request.httpBody = requestBody
        }
        catch{
            print("Error creating the data object from json")
        }
        
        // Set the request type
        request.httpMethod = "POST"
        
        // Get the URLSession
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            // Check for errors - if there was no errors (nil)
            if error == nil && data != nil {
                
                // Try to parse out the data - force unwrap data! because we already checked it
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                    print(dictionary)
                }
                catch{
                    print("Error parsing response data")
                }
            }
        }
        
        // Fire off the data task
        dataTask.resume()
        
        
        
        // Set friend carousel
//        collectionView.dataSource = self
//        collectionView.register(DiscoverFriendCollectionViewCell.nib(), forCellWithReuseIdentifier: DiscoverFriendCollectionViewCell.identifier)
        let cellNib = UINib(nibName: "DiscoverWebTableViewCell", bundle: nil)

        let friendNib = UINib(nibName: "DiscoverFriendTableViewCell", bundle: nil)
//        let friendNib = UINib(nibName: "DiscoverFriendCollectionViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UITableView

        tableView.register(friendNib, forCellReuseIdentifier: "DiscoverFriendTableViewCell")
//        tableView.register(DiscoverFriendTableViewCell.nib(), forCellReuseIdentifier: DiscoverFriendTableViewCell.identifier)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

// Why we create a new extension is to group related code to each other
// UICollectionViewDataSource

// Friend Layout
//extension DiscoverViewController: UICollectionViewDataSource{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverFriendCollectionViewCell.identifier, for: indexPath) as! DiscoverFriendCollectionViewCell
//        let item = items[indexPath.item]
//
//        // When we set the item for this cell, didSet property observer gets called in DiscoverFriendsCollectionViewController
//        // The the UpdateUI will set this property
//        cell.item = item
//
//        return cell
//    }
//}

// Web Layout
extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
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
}
