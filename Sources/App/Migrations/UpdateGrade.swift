import Foundation
import Fluent
struct UpdateGrad :Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("grade")

            .field("course_id", .uuid, .required, .references("course", "id")).update()
         
        
                 
           
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("grade").delete()
    }
    
    
}

