//
//  PostAPI.swift
//  expchef
//
//  Created by Colin To on 2022-04-12.
//

struct PostAPI: Codable{
    let id: String
    let title: String?
    let cuisines: String?
    let image: String?
    let extendedIngredients: PostIngredients
}

struct PostIngredients: Codable {
    let aisle: String?
}
