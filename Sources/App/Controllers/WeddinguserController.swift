import Fluent
import Vapor

struct WeddinguserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let weddingusers = routes.grouped("weddingusers")
        weddingusers.get(use: index)
        weddingusers.post(use: create)
        weddingusers.patch(use: confirm)
        let vueuserlist = routes.grouped("listvue")
        vueuserlist.get(use: listvue)
        let vueusercheck = routes.grouped("checkvue")
        vueusercheck.post(use: checkvue)
        let vueusercreate = routes.grouped("createvue")
        vueusercreate.post(use: createvue)
        let vueuserconfirm = routes.grouped("confirmvue")
        vueuserconfirm.post(use: confirmvue)
    }
    func listvue(req: Request) async throws -> [Vueuser] {
        try await Vueuser.query(on: req.db).all()
    }
    func createvue(req: Request) async throws -> Vueuser {
        let vueuserinput = try req.content.decode(VueuserInput.self)
        let vueuser = Vueuser(fullname: vueuserinput.fullname, attending: "unset")
        try await vueuser.save(on: req.db)
        return vueuser
    }
    func checkvue(req: Request) async throws -> Vueuser {
        let vueuserfullname = try req.content.decode(VueuserInput.self).fullname
        let vueuserlookup = try await Vueuser.query(on: req.db).filter(\.$fullname == vueuserfullname).first()
        if vueuserlookup == nil {
            return Vueuser(fullname: vueuserfullname, attending: "notfound")
        }else{
            return vueuserlookup!
        }
    }
    func confirmvue(req: Request) async throws -> Vueuser {
        let vueuserconfirmation = try req.content.decode(VueuserConfirmation.self)
        var vueuser = try await Vueuser.query(on: req.db).filter(\.$fullname == vueuserconfirmation.fullname).first()
        vueuser?.attending = vueuserconfirmation.attendance ? "attending" : "notattending"
        try await vueuser?.save(on: req.db)
        return vueuser ?? Vueuser(fullname: "not found", attending: "not found")
    }
    func index(req: Request) async throws -> [Weddinguser] {
        try await Weddinguser.query(on: req.db).filter(\.$confirmed == true).all()
    }
    func create(req: Request) async throws -> Weddinguser {
        //print("req.content:\(req.content)")
        let weddinguserinput = try req.content.decode(WeddinguserInput.self)
        let weddinguser = Weddinguser(firstname: weddinguserinput.firstname, lastname: weddinguserinput.lastname, emailaddress: weddinguserinput.emailaddress, note: weddinguserinput.note ?? "")
        //let weddinguser = try req.content.decode(Weddinguser.self)
        try await weddinguser.save(on: req.db)
        return weddinguser
    }
    func confirm(req: Request) async throws -> Weddinguser {
        let weddinguserconfirmation = try req.content.decode(WeddinguserID.self)
        var usermatch = try await Weddinguser.query(on: req.db).filter(\.$id == weddinguserconfirmation.weddinguserid).first()
        usermatch?.confirmed = weddinguserconfirmation.confirmed
        try await usermatch?.save(on: req.db)
        return usermatch ?? Weddinguser(firstname: "invalid", lastname: "invalid", emailaddress: "invalid")
    }
}
final class WeddinguserInput: Content {
    var firstname: String
    var lastname: String
    var emailaddress: String
    var note: String?
}
final class WeddinguserID: Content {
    var weddinguserid: UUID
    var confirmed: Bool
}
final class VueuserInput: Content{
    var fullname: String
}
final class VueuserConfirmation: Content{
    var fullname: String
    var attendance: Bool
}
