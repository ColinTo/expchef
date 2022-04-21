//
//  RecipeWorkingCollectionViewCell.swift
//  expchef
//
//  Created by Colin To on 2022-04-20.
//

import UIKit

class RecipeWorkingCollectionViewCell: UICollectionViewCell {

    static let identifier = "RecipeWorkingCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "RecipeWorkingCollectionViewCell",
                     bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
