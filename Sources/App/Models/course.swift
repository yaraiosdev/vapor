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
    @Parent(key: "instuctor_id" )
    var instuctor_id :Instructors


    init() {
        
    }
    init(id:UUID? = nil, courseName:String ,ininstuctorId:UUID) throws {
        self.id = id
        self.courseName = courseName
        self.$instuctor_id.id = ininstuctorId
      
        
    }
}
