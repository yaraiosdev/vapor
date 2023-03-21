//
//  Student.swift
//  
//
//  Created by duaa mohammed on 14/03/2023.
//

import Fluent
import Vapor
final class student :Model , Content{
    static let schema = "students"
    @ID (key: .id)
    var id :UUID?
    @Field(key : "studentName")
    var studentName : String
    @Children (for:\.$student_id)
    var gradeList:[grade]
    init() {
        
    }
    init(id:UUID? = nil, studentName:String  ) throws {
        self.id = id
        self.studentName = studentName
      
        
    }
}
// we need to select the type of the database 
