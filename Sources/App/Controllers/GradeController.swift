//
//  File.swift
//  
//
//  Created by yara mohammed alqahtani on 16/03/2023.
//

import Vapor
import Fluent
struct GradeController :RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let grade = routes.grouped("grade")
        grade.get(use :readAll)
        grade.get(":id" , use: read)
        grade.post(use:post)
        grade.delete(":id", use:delete)
        grade.put(use:update)
        
    
        
    }
    func readAll (req:Request) throws -> EventLoopFuture<[grade]>{
        grade.query(on: req.db).all()
    }
    func post (req:Request) throws -> EventLoopFuture<grade>{
        let grade = try req.content.decode(grade.self)
        return grade.create(on: req.db)
            .map{grade}
        
    }
    
//    func getelement (req:Request)  throws -> EventLoopFuture<Instructors>{
//        Instructors.find(req.parameters.get("instructorName"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//    }
    func read(req: Request) throws -> EventLoopFuture<grade> {
           guard let id = req.parameters.get("id", as: UUID.self) else {
               throw Abort(.badRequest)
           }
        return grade.find(id, on: req.db).unwrap(or: Abort(.notFound))
                    }
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        return grade.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
                        .map { .ok }
            
    
    }
    func update (req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let id = try req.content.decode(grade.self)
        
        return grade.find(id.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.score = id.score
                return $0.update(on: req.db).transform(to: .ok)
            }
    }

    
}


