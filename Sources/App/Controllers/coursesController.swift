//
//  File.swift
//
//
//  Created by duaa mohammed on 15/03/2023.
//

import Vapor
import Fluent
struct coursesController :RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let course = routes.grouped("course")
        course.get(use :readAll)
        course.get(":id" , use: read)
        course.post(use:post)
        course.delete(":id", use:delete)
        course.put(use:update)
        
    
        
    }
    func readAll (req:Request) throws -> EventLoopFuture<[course]>{
        course.query(on: req.db).all()
    }
    func post (req:Request) throws -> EventLoopFuture<course>{
        let course = try req.content.decode(course.self)
        return course.create(on: req.db)
            .map{course}
        
    }
    
//    func getelement (req:Request)  throws -> EventLoopFuture<Instructors>{
//        Instructors.find(req.parameters.get("instructorName"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//    }
    func read(req: Request) throws -> EventLoopFuture<Instructors> {
           guard let id = req.parameters.get("id", as: UUID.self) else {
               throw Abort(.badRequest)
           }
        return Instructors.find(id, on: req.db).unwrap(or: Abort(.notFound))
                    }
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return Instructors.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
                        .map { .ok }
            
    
    }
    func update (req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let id = try req.content.decode(course.self)
        
        return course.find(id.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.courseName = id.courseName
                return $0.update(on: req.db).transform(to: .ok)
            }
    }

    
}


