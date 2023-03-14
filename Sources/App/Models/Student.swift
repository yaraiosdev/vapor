//
//  Student.swift
//  
//
//  Created by duaa mohammed on 14/03/2023.
//

import Fluent
import Vapor
final class Student :Model , Content{
    static let schema = "Students"
    @ID (key: .id)
    var id :UUID?
    @Field(key : "name")
    var name : String
    @Field(key : "lastName")
    var lastName :String
    init() {
        
    }
    init(id:UUID? = nil, name:String ,lastName:String ) throws {
        self.id = id
        self.name = name
        self.lastName = lastName
        
    }
}
