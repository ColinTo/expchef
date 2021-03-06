//
//  DiscoverFriendsCollectionViewCell.swift
//  expchef
//
//  Created by Colin To on 2022-04-03.
//

import UIKit

//class DiscoverFriendCollectionViewCell: UITableViewCell {
class DiscoverFriendCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DiscoverFriendCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "DiscoverFriendCollectionViewCell",
                     bundle: nil)
    }
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodTitleLabel: UILabel!
    @IBOutlet weak var backgroundColorView: UIView!
    
    var item: Item!{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        if let item = item{
            // Assign Image to Model image (FireBase in the future)
            foodImageView.image = item.foodImage
            foodTitleLabel.text = item.title
            foodTitleLabel.frame.size.width = 180
            backgroundColorView.backgroundColor = item.color
        }
        else{
            foodImageView.image = nil
            foodTitleLabel.text = nil
            backgroundColorView.backgroundColor = nil
        }
        
        
        // This can probably be removed
        backgroundColorView.layer.cornerRadius = 10.0
        backgroundColorView.layer.masksToBounds = true
        
        // Keep This
//        foodImageView.layer.cornerRadius = 10.0
//        foodImageView.layer.masksToBounds = true
    }
}


