//
//  File.swift
//  
//
//  Created by duaa mohammed on 15/03/2023.
//

import Fluent
import Vapor
final class Instructors :Model , Content{
    static let schema = "instructors"
    @ID (key: .id)
    var id :UUID?
    @Field(key : "instructorName")
    var instructorName : String
    @Children (for:\.$instuctor_id)
    var couresList:[course]

    init() {
        
    }
    init(id:UUID? = nil, instructorName:String  ) throws {
        self.id = id
        self.instructorName = instructorName
       
        
    }
}
// we need to select the type of the database
