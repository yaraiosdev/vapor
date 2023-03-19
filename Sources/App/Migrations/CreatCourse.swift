//
//  File.swift
//  
//
//  Created by duaa mohammed on 19/03/2023.
//

import Foundation
import Foundation
import Fluent
struct CreatCourse :Migration {
func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
return database.schema("course")
.id()
.field("courseName",.string,.required)
.field("instructor_id", .uuid, .required, .references("instructors", "id"))
        .create()
        
}

func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
    return database.schema("course").delete()
}
}
