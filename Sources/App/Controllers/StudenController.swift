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
        let students = routes.grouped("student")
        students.get(use :index)
        students.post(use: post)
        
    
        
    }
    func index (req:Request) throws -> EventLoopFuture<[Student]>{
        try  Student.query(on: req.db).all()
    }
    func post (req:Request) throws -> EventLoopFuture<Student>{
        let student = try req.content.decode(Student.self)
        return student.create(on: req.db)
            .map{student}
        
    }
    
    
}
