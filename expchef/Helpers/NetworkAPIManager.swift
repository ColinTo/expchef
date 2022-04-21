//
//  NetworkAPIManager.swift
//  expchef
//
//  Created by Colin To on 2022-04-12.
//

import Foundation

enum NetworkAPIManagerError: Error{
    case badReponse(URLResponse?)
    case badData
}

fileprivate struct APIResponse: Codable {
    let results: [PostAPI]
}

class NetworkAPIManager{
    
    static var shared = NetworkAPIManager()
    
    let session: URLSession
    
    init(){
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func components() -> URLComponents{
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.spoonacular.com"
        component.path = "/recipes/716429/information"
        component.queryItems = [URLQueryItem]()
        component.queryItems?.append(URLQueryItem(name: "apiKey", value: "a47725a611ac4d5291b7019338a8f96b"))
//        component.queryItems?.append(URLQueryItem(name: "number", value: "12"))
        return component
    }
    
    func request(url: URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    func posts(query: String, completion: @escaping ([PostAPI]?, Error?) -> (Void)){
        var component = components()
//        component.path = "/recipes/716429/information"
////        component.path = component.path+"?apiKey=7ab2d544461d46f4ac0dfaacda9c2371"
//        component.queryItems = [
//            URLQueryItem(name: "apiKey", value: "7ab2d544461d46f4ac0dfaacda9c2371")
////            URLQueryItem(name: "query", value: query)
//        ]
        
        let req = request(url: component.url!)
        
        print(component.url!)
        
        
        let task = session.dataTask(with: req){ data, response, error in
            if let error = error{
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else{
                completion(nil, NetworkAPIManagerError.badReponse(response))
                return
            }
            
            guard let data = data else{
                completion(nil, NetworkAPIManagerError.badData)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(response.results, nil)
            }
            
            catch let error{
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
