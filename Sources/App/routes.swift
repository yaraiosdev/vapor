import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        "it works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    
try app.register(collection:StudenController())
try app.register(collection: inspectorController())

    
}
