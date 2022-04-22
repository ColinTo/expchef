//
//  ProfileViewController.swift
//  expchef
//
//  Created by Colin To on 2022-04-05.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var avatar = Avatar.fetchDetails()
    
    var friendList:[String] = []
    var profileImages:[String] = []
    var profileNames:[String] = []
//    var data: [Any] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var profilePicture: UIView!

    // Creating a hosting controller. Root view will be our SwiftUI content view
    fileprivate let contentViewinHC = UIHostingController(rootView: RadarSwiftUIView(width: 30, height: 60, MainColor: Color.init(white:0.8), SubtleColor: Color.init(white: 0.6), quantity_incrementDividers: 4, dimensions: dimensions, data: chartData))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHC()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileFriendIconViewCell.self, forCellWithReuseIdentifier: ProfileFriendIconViewCell.identifer)
        setupConstraints()
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
        let db = Firestore.firestore()
        
        // Populate everyone from your friend list - THIS WORKS, BUT ASYNCHRONOUS
//        db.collection("users").whereField("email", isEqualTo: "colin.qlt@gmail.com").getDocuments(){(querySnapshot, err) in
//            if let err = err{
//                print("Error getting documents: \(err)")
//            }
//            else{
//                for document in querySnapshot!.documents{
//                    self.friendList = document.get("friends_id_list") as! [String]
////                    print(self.friendList.shuffled())
//                }
//            }
//        }
//
        Storage.storage().reference().child("images/recipe_banners/file.png")
//        storage.child("images/recipe_banners/file.png").downloadURL(completion: {url, error in
//            guard let url = url, error == nil else {
//                return
//            }
//
//            // Original
//    //                let urlString = url.absoluteString
//            // Luffy Test - Luffy only changes when picker appears and after you upload. Put this in viewload in profileviewlater
//            let urlString = "https://firebasestorage.googleapis.com/v0/b/expchef.appspot.com/o/images%2Favatars%2Fdp_luffy.jpg?alt=media&token=0209f366-eb7b-4839-b980-fa80810d8e38"
//            print("Download URL: \(urlString)")
//
//            DispatchQueue.main.async {
//                self.label.text = urlString
//                self.imageView.image = image
//            }
//
//            // This is so we can later download the latest image
//            UserDefaults.standard.set(urlString, forKey: "url")
//        })
        
//        print(self.friendList)
//        for uid in self.friendList{
//            db.collection("users").document(uid).getDocument(){(querySnapshot, err) in
//                if let err = err{
//                    print("Error getting documents: \(err)")
//                }
//                else{
////                    print(querySnapshot)
//                    if let document = querySnapshot{
//                        let id = document.documentID
//                        let data = document.data()
//                        let name = data?["firstname"] as? String ?? ""
//                        self.profileNames.append(name)
//                        let profileImage = data?["profileImageUrl"] as? String ?? ""
//                        self.profileImages.append(profileImage)
////                        print(id)
////                        print(name)
////                        print(self.profileNames)
//                    }
//                }
//            }
//        }
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
        let avatars = avatar[indexPath.item]
//        cell.item = avatars
//        let name = profileNames[indexPath.item]
//        cell.name.text = name
        cell.profilePicture.image = avatars.image
        cell.name.text = avatars.name
        return cell
    }
}
