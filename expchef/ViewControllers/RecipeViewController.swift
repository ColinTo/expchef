//
//  RecipeViewController.swift
//  expchef
//
//  Created by Colin To on 2022-04-02.
//

import UIKit
import FirebaseStorage

class RecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var foodName: UITextView!
    
    // Holds data for Views
    var fname = ""
    
    // Reference to Firebase storage system
    private let storage = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Allows it to have n number of lines on line wrap
        label.numberOfLines = 0
        label.textAlignment = .center
        imageView.contentMode = .scaleAspectFit
        foodName.text = fname
        
        guard let urlString = UserDefaults.standard.value(forKey:"url") as? String,
        let url = URL(string: urlString) else{
            return
        }
        
        label.text = urlString
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            DispatchQueue.main.async{
                let image = UIImage(data: data)
                self.imageView.image = image
            }

        })
        
        task.resume()
    }
    
    @IBAction func didTapButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        guard let imageData = image.pngData() else{
            return
        }
       
        /* Create reference from firebase - eg. /Desktop/file.png
        */
        
        storage.child("images/recipe_banners/file.png").putData(imageData, metadata: nil, completion: {_, error in
            
            guard error == nil else{
                print("Failed to upload")
                return
            }
            
            self.storage.child("images/recipe_banners/file.png").downloadURL(completion: {url, error in
                guard let url = url, error == nil else {
                    return
                }
                
                // Original
                let urlString = url.absoluteString
                // Luffy Test - Luffy only changes when picker appears and after you upload. Put this in viewload in profileviewlater
//                let urlString = "https://firebasestorage.googleapis.com/v0/b/expchef.appspot.com/o/images%2Favatars%2Fdp_luffy.jpg?alt=media&token=0209f366-eb7b-4839-b980-fa80810d8e38"
                print("Download URL: \(urlString)")
                
                DispatchQueue.main.async {
                    self.label.text = urlString
                    self.imageView.image = image
                }
                
                // This is so we can later download the latest image
                UserDefaults.standard.set(urlString, forKey: "url")
            })
        })
        
        // upload image data
        // get download url
        // save download url to userDefaults
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
}
