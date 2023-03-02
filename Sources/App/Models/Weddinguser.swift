import Fluent
import Vapor

final class Weddinguser: Model, Content {
    static let schema = "weddingusers"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "firstname")
    var firstname: String

    @Field(key: "lastname")
    var lastname: String

    @Field(key: "emailaddress")
    var emailaddress: String

    @Field(key: "note")
    var note: String?
    
    @Field(key: "confirmed")
    var confirmed: Bool

    init() { }

    init(id: UUID? = nil, firstname: String, lastname: String, emailaddress: String, note: String = ""){
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.emailaddress = emailaddress
        self.note = note
        self.confirmed = false
    }
}
final class Vueuser: Model, Content {
    static let schema = "vueusers"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "fullname")
    var fullname: String

    @Field(key: "attending")
    var attending: String

    init() { }

    init(id: UUID? = nil, fullname: String, attending: String){
        self.id = id
        self.fullname = fullname
        self.attending = attending
    }
}
