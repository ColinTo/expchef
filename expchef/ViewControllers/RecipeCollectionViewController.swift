//
//  RecipeCollectionViewController.swift
//  expchef
//
//  Created by Colin To on 2022-04-02.
//

import UIKit

class RecipeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet var generalCollectionView: UICollectionView!
    @IBOutlet var workingCollectionView: UICollectionView!

    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You tapped me")
    }


    // DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.workingCollectionView{
            return 5
        }
        
        // Return 12 for general collections
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.workingCollectionView{
            let workingcell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeWorkingCollectionViewCell.identifier, for: indexPath) as! RecipeWorkingCollectionViewCell
            return workingcell
        }
        else{
            let generalcell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeGeneralCollectionViewCell.identifier, for: indexPath) as! RecipeGeneralCollectionViewCell
            return generalcell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        generalCollectionView.delegate = self
        generalCollectionView.dataSource = self
        workingCollectionView.delegate = self
        workingCollectionView.dataSource = self
        generalCollectionView.register(RecipeGeneralCollectionViewCell.nib(), forCellWithReuseIdentifier: RecipeGeneralCollectionViewCell.identifier)
        workingCollectionView.register(RecipeWorkingCollectionViewCell.nib(), forCellWithReuseIdentifier: RecipeWorkingCollectionViewCell.identifier)
        
//        generalCollectionView.reloadData()
//        workingCollectionView.reloadData()
    }
}
