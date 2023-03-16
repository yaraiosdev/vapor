//
//  File.swift
//  
//
//  Created by yara mohammed alqahtani on 16/03/2023.
//

import Fluent
import Vapor
final class course :Model , Content{
    static let schema = "course"
    @ID (key: .id)
    var id :UUID?
    @Field(key : "courseName")
    var courseName : String

    init() {
        
    }
    init(id:UUID? = nil, courseName:String  ) throws {
        self.id = id
        self.courseName = courseName
      
        
    }
}
