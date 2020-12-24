//
//  ObjectAPI.swift
//  TestTask
//
//  Created by Maryna Bereza on 12/23/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import Foundation


class ObjectTypeAPIModel  {

    var value: String
    var isText: Bool = true

    init(dict: Dictionary<String, String>) {
        
        let type = dict["type"]
        let textValue: String?
        
        if type == "text" {
            isText = true
            textValue = dict["contents"]!
            
        } else if type == "webview" {
            isText = false
            textValue = dict["url"]!
            
        } else {
            isText = true
            textValue = "Unsupported type!"
        }
        
        if let textValue = textValue {
            value = textValue
        } else {
            value = "No data"
        }
    }
}


