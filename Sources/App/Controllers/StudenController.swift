//
//  StudentController.swift
//  
//
//  Created by duaa mohammed on 14/03/2023.
//

import Vapor
import Fluent
struct StudentController :RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let students = routes.grouped("Student")
        students.get(use :index)
        
    }
    func index (req:Request) throws -> EventLoopFuture<[Student]>{
        try await Todo.query(on: req.db).all()
        try await Student.query(on: req.db).all()
    }
    
    
    
}
