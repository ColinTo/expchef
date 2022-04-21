//
//  DiscoverFriendTableViewCell.swift
//  expchef
//
//  Created by Colin To on 2022-04-04.
//

import UIKit

class DiscoverFriendTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    static let identifier = "DiscoverFriendTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "DiscoverFriendTableViewCell",
                     bundle: nil)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Download the data from the Internet or FireBase or Realm
    var items = Item.fetchItem()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DiscoverFriendCollectionViewCell.nib(), forCellWithReuseIdentifier: DiscoverFriendCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverFriendCollectionViewCell.identifier, for: indexPath) as! DiscoverFriendCollectionViewCell
        let item = items[indexPath.item]
        
        // When we set the item for this cell, didSet property observer gets called in DiscoverFriendCollectionViewController
        // The the UpdateUI will set this property
        cell.item = item
        
        return cell
    }
    
    // When Friend Recipes Collection is Clicked
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let recipeview = super.storyboard?.instantiateViewController(identifier: "RecipeVC") as? RecipeViewController{
//            recipeview.fname = items[indexPath.row-1].title
//            self.navigationController?.pushViewController(recipeview, animated: true)
//        }
//    }

}
