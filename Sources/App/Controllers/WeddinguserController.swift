import Fluent
import Vapor

struct WeddinguserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let weddingusers = routes.grouped("weddingusers")
        weddingusers.get(use: index)
        weddingusers.post(use: create)
    }
    func index(req: Request) async throws -> [Weddinguser] {
        try await Weddinguser.query(on: req.db).all()
    }
    func create(req: Request) async throws -> Weddinguser {
        //print("req.content:\(req.content)")
        let weddinguserinput = try req.content.decode(WeddinguserInput.self)
        let weddinguser = Weddinguser(firstname: weddinguserinput.firstname, lastname: weddinguserinput.lastname, emailaddress: weddinguserinput.emailaddress, note: weddinguserinput.note ?? "")
        //let weddinguser = try req.content.decode(Weddinguser.self)
        try await weddinguser.save(on: req.db)
        return weddinguser
    }
}
final class WeddinguserInput: Content {
    var firstname: String
    var lastname: String
    var emailaddress: String
    var note: String?
}
