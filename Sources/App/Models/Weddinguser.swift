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
    var note: String

    init() { }

    init(id: UUID? = nil, firstname: String, lastname: String, emailaddress: String, note: String = ""){
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.emailaddress = emailaddress
        self.note = note
    }
}
