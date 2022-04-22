//
//  Avatar.swift
//  expchef
//
//  Created by Colin To on 2022-04-21.
//

import UIKit

class Avatar
{
    var name = ""
    var image = UIImage()
    
    init(name: String, image: UIImage){
        self.name = name
        self.image = image
    }
    
    static func fetchDetails() -> [Avatar]
    {
        return [
            Avatar(name: "Sanji",
                   image:UIImage(named: "dp_sanji")!),
            Avatar(name: "Aaron",
                   image:UIImage(named: "i_pizza")!),
            Avatar(name: "Luffy",
                   image:UIImage(named: "dp_luffy")!),
            Avatar(name: "Robin",
                   image:UIImage(named: "dp_robin")!),
        ]
    }
}
