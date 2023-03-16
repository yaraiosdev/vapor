//
//  File.swift
//
//
//  Created by yara mohammed alqahtani on 16/03/2023.
//

import Fluent
import Vapor
final class grade :Model , Content{
    static let schema = "grade"
    @ID (key: .id)
    var id :UUID?
    @Field(key : "score")
    var score : String

    init() {
        
    }
    init(id:UUID? = nil, score:String  ) throws {
        self.id = id
        self.score = score
      
        
    }
}
