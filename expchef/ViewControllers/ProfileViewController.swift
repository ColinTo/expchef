//
//  ProfileViewController.swift
//  expchef
//
//  Created by Colin To on 2022-04-05.
//

import UIKit
import SwiftUI

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    // Creating a hosting controller. Root view will be our SwiftUI content view
    fileprivate let contentViewinHC = UIHostingController(rootView: RadarSwiftUIView(width: 30, height: 60, MainColor: Color.init(white:0.8), SubtleColor: Color.init(white: 0.6), quantity_incrementDividers: 4, dimensions: dimensions, data: chartData))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHC()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileFriendIconViewCell.self, forCellWithReuseIdentifier: ProfileFriendIconViewCell.identifer)
        setupConstraints()
    }
    
    fileprivate func setupConstraints(){
        contentViewinHC.view.translatesAutoresizingMaskIntoConstraints = false
        contentViewinHC.view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        contentViewinHC.view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        contentViewinHC.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentViewinHC.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

    }
    
    fileprivate func setupHC(){
        // Here's we're adding controller for Radar to ProfileViewController
        addChild(contentViewinHC)
        // Here we're adding our Radar's View to our ProfileViewController's view
        view.addSubview(contentViewinHC.view)
        // Called after the view controller is added or removed from container view controller. Moving from swiftUI to UIKit
        contentViewinHC.didMove(toParent: self)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileFriendIconViewCell.identifer, for: indexPath) as! ProfileFriendIconViewCell
        return cell
    }
}
