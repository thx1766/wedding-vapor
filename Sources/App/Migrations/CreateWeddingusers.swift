import Fluent

struct CreateWeddingusers: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("weddingusers")
        .id()
        .field("firstname", .string, .required)
        .field("lastname", .string, .required)
        .field("emailaddress", .string, .required)
        .field("note", .string)
        .field("confirmed", .bool)
        .create()
    }
    func revert(on database: Database) async throws{
        try await database.schema("weddingusers").delete()
    }
}

struct CreateVueusers: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("vueusers")
        .id()
        .field("fullname", .string, .required)
        .field("attending", .string, .required)
        .create()
    }
    func revert(on database: Database) async throws{
        try await database.schema("vueusers").delete()
    }
}
