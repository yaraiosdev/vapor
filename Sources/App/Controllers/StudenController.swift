//
//  File.swift
//
//
//  Created by duaa mohammed on 15/03/2023.
//

import Vapor
import Fluent
struct StudenController :RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let students = routes.grouped("student")
        students.get(use :readAll)
        students.get(":id" , use: read)
        students.post(use:post)
        students.delete(":id", use:delete)
        students.put(use:update)
        
    
        
    }
    func readAll (req:Request) throws -> EventLoopFuture<[student]>{
        student.query(on: req.db).all()
    }
    
    
    func post (req:Request) throws -> EventLoopFuture<student>{
        let student = try req.content.decode(student.self)
        return student.create(on: req.db)
            .map{student}
        
    }
    
//    func getelement (req:Request)  throws -> EventLoopFuture<Instructors>{
//        Instructors.find(req.parameters.get("instructorName"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//    }
    func read(req: Request) throws -> EventLoopFuture<student> {
           guard let id = req.parameters.get("id", as: UUID.self) else {
               throw Abort(.badRequest)
           }
        return student.find(id, on: req.db).unwrap(or: Abort(.notFound))
                    }
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return student.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
                        .map { .ok }
            
    
    }
    func update (req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let id = try req.content.decode(student.self)
        
        return student.find(id.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.studentName = id.studentName
                return $0.update(on: req.db).transform(to: .ok)
            }
    }

    
}

