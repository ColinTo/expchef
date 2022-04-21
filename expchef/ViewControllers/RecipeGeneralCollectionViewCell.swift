//
//  RecipeGeneralCollectionViewCell.swift
//  expchef
//
//  Created by Colin To on 2022-04-20.
//

import UIKit

class RecipeGeneralCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecipeGeneralCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "RecipeGeneralCollectionViewCell",
                     bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
