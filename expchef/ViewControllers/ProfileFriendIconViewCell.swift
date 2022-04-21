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

    var imageView = UIImageView()
    var label = UILabel()
    var friendList:[String] = []
//    var friendList:[String] = []
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let db = Firestore.firestore()
        
        // Populate everyone from your friend list
        db.collection("users").whereField("email", isEqualTo: "colin.qlt@gmail.com").getDocuments(){(querySnapshot, err) in
            if let err = err{
                print("Error getting documents: \(err)")
            }
            else{
                for document in querySnapshot!.documents{
                    self.friendList = document.get("friends_id_list") as! [String]
                    print(self.friendList)
                }
            }
        }
        
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

        
        imageView.image = UIImage(systemName: "house")
        imageView.backgroundColor = UIColor.green
        contentView.addSubview(imageView)

        // Customize labelview
        label.text = "Hello"
        label.textColor = UIColor.init(red: 169, green: 169, blue: 169, alpha: 1)
        contentView.addSubview(label)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: (contentView.frame.size.width/2)-20,
                              y: contentView.frame.size.height-25,
                              width: contentView.frame.size.width-10,
                              height: 20)
        
        imageView.frame = CGRect(x: (contentView.frame.size.width/2)-30,
                              y: 10,
                              width: contentView.frame.size.width-20,
                              height: 60)
    
    }
}
