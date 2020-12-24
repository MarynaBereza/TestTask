//
//  ServerManager.swift
//  TestTask
//
//  Created by Maryna Bereza on 12/23/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import Foundation

class ServerManager {
    
    static func fetchRequestObjectsList(completion: @escaping(_ list: [ObjectAPIModel]) -> ()) {
        
        let objListURL:URL = URL(string: "https://demo0040494.mockable.io/api/v1/trending")!
        
        let task = URLSession.shared.dataTask(with: objListURL) {(data, response, error) in
            
            guard let data = data else {
                return
            }
            
            if let error = error {
                print(error)
            } else {
                
                let objModel = try! JSONDecoder().decode(Array<ObjectAPIModel>.self, from: data)
                
                DispatchQueue.main.async {
                    completion(objModel)
                }
            }
        }
        task.resume()
    }
    
    
   static func fetchRequestObject(with id:Int, completion: @escaping(_ obj: ObjectTypeAPIModel) -> ()) {
        
        let objListURL:URL = URL(string: "https://demo0040494.mockable.io/api/v1/object/\(id)")!
        
        let task = URLSession.shared.dataTask(with: objListURL) {(data, response, error) in
            
            guard let data = data else {
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            guard let dataStr = String(data: data, encoding: .utf8) else {
                return
            }
            
            if let error = error {
                print(error)
            } else {
                
                let objectDict = self.convertStringToDictionary(text: dataStr)
                
                let obj = ObjectTypeAPIModel.init(dict: objectDict as! [String: String])
                
                DispatchQueue.main.async {
                    completion(obj)
                }
            }
        }
        task.resume()
    }
    
    
    static func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}



