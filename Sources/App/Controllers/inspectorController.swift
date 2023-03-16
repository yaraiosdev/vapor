//
//  File.swift
//  
//
//  Created by duaa mohammed on 15/03/2023.
//

import Vapor
import Fluent
struct inspectorController :RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let instructors = routes.grouped("inspector")
        instructors.get(use :readAll)
        instructors.get(":id" , use: read)
        instructors.post(use:post)
        instructors.delete(":id", use:delete)
        instructors.put(use:update)
        
    
        
    }
    func readAll (req:Request) throws -> EventLoopFuture<[Instructors]>{
     Instructors.query(on: req.db).all()
    }
    func post (req:Request) throws -> EventLoopFuture<Instructors>{
        let instructor = try req.content.decode(Instructors.self)
        return instructor.create(on: req.db)
            .map{instructor}
        
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
        let id = try req.content.decode(Instructors.self)
        
        return Instructors.find(id.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.instructorName = id.instructorName
                return $0.update(on: req.db).transform(to: .ok)
            }
    }

    
}

