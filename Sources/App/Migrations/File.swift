import Foundation
import Fluent
struct UpdateGrade :Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("grade")
            //   .id()
        //   .field("score",.string,.required)
            .field("course_id", .uuid, .required, .references("courses", "id")).update()
          //.field("student_id", .uuid, .required, .references("students", "id"))
        
                 
           
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("grade").delete()
    }
    
    
}

