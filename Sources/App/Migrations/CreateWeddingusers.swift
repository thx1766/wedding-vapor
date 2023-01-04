import Fluent

struct CreateWeddingusers: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("weddingusers")
        .id()
        .field("firstname", .string, .required)
        .field("lastname", .string, .required)
        .field("emailaddress", .string, .required)
        .field("note", .string)
        .create()
    }
    func revert(on database: Database) async throws{
        try await database.schema("weddingusers").delete()
    }
}