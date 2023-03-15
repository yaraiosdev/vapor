//
//  File.swift
//  
//
//  Created by duaa mohammed on 14/03/2023.
//

import Foundation
import Fluent
struct CreatStudents :Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("students")
            .id()
            .field("studentName",.string,.required)
      
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("students").delete()
    }
    
    
}
