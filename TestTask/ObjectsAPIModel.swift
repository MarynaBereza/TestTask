//
//  ObjectModel.swift
//  TestTask
//
//  Created by Maryna Bereza on 12/23/20.
//  Copyright © 2020 Bereza Maryna. All rights reserved.
//

import Foundation

struct ObjectAPIModel {
    
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

extension ObjectAPIModel: Decodable {
    
    init(from decoder: Decoder) throws  {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
    }
}
