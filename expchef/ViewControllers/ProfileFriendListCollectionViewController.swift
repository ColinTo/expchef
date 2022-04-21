//
//  ProfileFriendCollectionController.swift
//  expchef
//
//  Created by Colin To on 2022-04-20.
//

import UIKit

class ProfileFriendListCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(ProfileFriendIconViewCell.self, forCellWithReuseIdentifier: ProfileFriendIconViewCell.identifer)
//        collectionView.register(ProfileFriendIconViewCell.self, forCellWithReuseIdentifier: cell)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
//        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileFriendIconViewCell.identifer, for: indexPath) as! ProfileFriendIconViewCell
        return cell
    }
}
