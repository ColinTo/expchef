//
//  ProfileFriendIconViewCell.swift
//  expchef
//
//  Created by Colin To on 2022-04-20.
//

import UIKit
import Firebase

class ProfileFriendIconViewCell: UICollectionViewCell{
    
    static let identifer = "FriendIconCell"
    
    // Download the data from the Internet or FireBase or Realm
    var items = Item.fetchItem()

    var profilePicture = UIImageView()
    var name = UILabel()
    var friendList:[String] = []
//    var friendList:[String] = []
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
//        db.collection("users").getDocuments(){(querySnapshot, err) in
//            if let err = err{
//                print("Error getting documents: \(err)")
//            }
//            else{
//                for document in querySnapshot!.documents{
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
        
//        let test = db.collection("users")
        
//        print(test)
//        contentView.backgroundColor = .systemRed
//        imageView = UIImageView(frame: self.bounds)

        //Customize imageview
//        Database.database().reference().child("users").observeSingleEvent(of: .value, with: { snapshot in
//
//            guard let value = snapshot.value as? [String: Any] else{
//                return
//            }
//
//            print(snapshot)
//
//        })

        
//        profilePicture.image = UIImage(systemName: "house")
//        profilePicture.backgroundColor = UIColor.green
//        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        profilePicture.layer.cornerRadius = 30
        profilePicture.clipsToBounds = true
        contentView.addSubview(profilePicture)

        // Customize labelview
//        name.text = "Hello"
        name.textColor = UIColor.init(red: 169, green: 169, blue: 169, alpha: 1)
        contentView.addSubview(name)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        name.frame = CGRect(x: (contentView.frame.size.width/2)-20,
                              y: contentView.frame.size.height-25,
                              width: contentView.frame.size.width-10,
                              height: 20)
        
        profilePicture.frame = CGRect(x: (contentView.frame.size.width/2)-30,
                              y: 10,
                              width: contentView.frame.size.width-20,
                              height: 60)
        
//        profilePicture.layer.cornerRadius = 10
        // Makes picture into circle
    
    }
    
//    var avatar: Avatar!{
//        didSet{
//            self.updateUI()
//        }
//    }
//    
//    func updateUI(){
//        if let avatar = avatar{
//            // Assign Image to Model image (FireBase in the future)
//            avatar.name = item.foodImage
//            avatar.image = item.title
//        }
//        else{
//            avatar.name.text = nil
//            avatar.image = nil
//        }
//    }
}
