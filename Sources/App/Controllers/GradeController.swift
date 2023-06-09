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
        grade.get("getcourse",":course_id" , use: getCourseGrade)
        grade.get("getStudent",":student_id" , use: getStudentGrade)
        grade.post(use:post)
        grade.delete(":id", use:delete)
        grade.put(use:update)
        //  grade.get(":id",use:readcourse)
        
        
        
    }
    func getCourseGrade (req:Request ) throws -> EventLoopFuture <[grade]>{
        guard let course_id = req.parameters.get("course_id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return grade.query(on: req.db).filter(\grade.$course_id.$id == course_id).all()
    }
    func getStudentGrade (req:Request ) throws -> EventLoopFuture <[grade]>{
        guard let student_id = req.parameters.get("student_id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return grade.query(on: req.db).filter(\grade.$student_id.$id == student_id).all()
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
    
    
    //    func readcourse(req: Request) async throws -> [grade] {
    //        guard let searchCourse = req.query[UUID.self , at : "course_id"]else {
    //            throw Abort (.badRequest)
    //        }
    //        return grade.query(on: req.db).filter(\.$course_id.id == searchCourse) .all()
    //
    //    }
    
    //get course by id
    
    //    func readcourse(req: Request) async throws -> [grade] {
    //        try await grade.query(on: req.db)
    //            .with(\.$score)
    //            .all()
    //
    //
    //    }
    //
    //         let grade =   grade.query(on: req.db)
    //            .filter(\.$score == "A")
    //            .first()
    //
    ////           guard let id = req.parameters.get("course_id", as: UUID.self) else {
    ////               throw Abort(.badRequest)
    ////           }
    ////        grade.query(on: req.db).filter(\.$0.course_id == id.course_id).all()
    ////
    //     return grade.find(grade, on: req.db).unwrap(or: Abort(.notFound))
    //                }
    
    //
    
    
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

    



