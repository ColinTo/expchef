//
//  Items.swift
//  expchef
//
//  Created by Colin To on 2022-04-03.
//

import UIKit

class Item
{
    var title = ""
    var foodImage: UIImage
    var color: UIColor
    
    init(title: String, foodImage: UIImage, color:UIColor){
        self.title = title
        self.foodImage = foodImage
        self.color = color
    }
    
    static func fetchItem() -> [Item]
    {
        return [
            Item(title: "Dumplings",
                 foodImage: UIImage(named: "f_dumplings")!,
                 color:UIColor(red:255,green:255,blue:255,alpha:1)),
            Item(title: "Fried Rice",
                 foodImage: UIImage(named: "f_friedrice")!,
                 color:UIColor(red:255,green:255,blue:255,alpha:1)),
            Item(title: "Pizza",
                 foodImage: UIImage(named: "f_pizza")!,
                 color:UIColor(red:255,green:255,blue:255,alpha:1))
        ]
    }
}
