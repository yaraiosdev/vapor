//
//  File.swift
//  
//
//  Created by duaa mohammed on 15/03/2023.
//

import Foundation
import Fluent
struct CreatInspecture :Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("instructors")
            .id()
            .field("instructorName",.string,.required)
      
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("instructors").delete()
    }
    
    
}
