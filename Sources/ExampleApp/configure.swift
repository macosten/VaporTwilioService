import Vapor
import Twilio

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    guard let accountId = Environment.get("TWILIO_ACCOUNT_ID") else { fatalError() }
    guard let accountSecret = Environment.get("TWILIO_ACCOUNT_SECRET") else { fatalError() }
    let twilio = Twilio(accountId: accountId, accountSecret: accountSecret)

    services.register(twilio)
}