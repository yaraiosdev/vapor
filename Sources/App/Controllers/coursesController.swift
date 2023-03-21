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
        course.get(":id",use: read)
        course.get ("getInstrctorCourses" , ":instructor_id" , use :getInstructoCourses)
        course.post(use:post)
        course.delete(":id", use:delete)
        course.put(use:update)
        
    
        
    }
    func getInstructoCourses (req:Request ) throws -> EventLoopFuture <[String]>{
        guard let instructor_id = req.parameters.get("instructor_id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
//        instructor_id
        
        return course.query(on: req.db).filter(\course.$instuctor_id.$id == instructor_id).all(\.$courseName)
    }
    func readAll (req:Request)async throws -> [course]{
     
        try await course.query(on: req.db)
            .with(\.$instuctor_id)
            .all()
        
//        course.query(on: req.db)
//            //.with(\.$instuctor_id)
//            .all()
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
    func read(req: Request) throws -> EventLoopFuture<course> {
           guard let id = req.parameters.get("id", as: UUID.self) else {
               throw Abort(.badRequest)
           }
        return course.find(id, on: req.db).unwrap(or: Abort(.notFound))
                    }
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return course.find(id, on: req.db)
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


