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
 @Parent(key: "course_id" )
   var course_id :course
    @Parent(key:"student_id")
    var student_id : student

    init() {
        
    }
    init(id:UUID? = nil, score:String , student_id:UUID  ,course_id:UUID) throws {
        self.id = id
        self.score = score
        self.$course_id.id = course_id
        self.$student_id.id = student_id
      
        
    }
}
