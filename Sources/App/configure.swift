import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    app.databases.use(.postgres(hostname: "localhost", username: "postgres", password: "" ,database: "gradingsys"),as: .psql)
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

//    app.databases.use(.postgres(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
//        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//    ), as: .psql)
//
    //app.migrations.add(CreateTodo())
//
//    app.views.use(.leaf)
        
    app.migrations.add(CreatInspecture())
    app.migrations.add(CreatStudents())
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}
