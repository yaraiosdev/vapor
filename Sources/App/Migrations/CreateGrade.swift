//
//  File.swift
//  
//
//  Created by yara mohammed alqahtani on 16/03/2023.
//
//
//  File.swift
//
//
//  Created by duaa mohammed on 14/03/2023.
//

import Foundation
import Fluent
struct CreatGrade :Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("grade")
            .id()
            .field("score",.string,.required)
      
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        return database.schema("grade").delete()
    }
    
    
}
