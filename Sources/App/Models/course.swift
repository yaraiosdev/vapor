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
    @Parent(key: "instructor_id" )
    var instuctor_id :Instructors
    
   @Children (for:\.$course_id)
   var gradeList:[grade]

    init() {
        
    }
    init(id:UUID? = nil, courseName:String ,ininstuctorId:UUID) {
        self.id = id
        self.courseName = courseName
        self.$instuctor_id.id = ininstuctorId
      
        
    }
}
