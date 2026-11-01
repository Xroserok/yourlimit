import Foundation
import Testing

@testable import UsageData

/// Fixtures are copied into the test bundle (`resources: [.copy("Fixtures")]`) and must load
/// through `Bundle.module`. DTO decoding of their content is covered by later tests.
@Suite struct FixtureLoadingTests {
    private func fixtureData(_ name: String) throws -> Data {
        let url = try #require(
            Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "Fixtures")
        )
        return try Data(contentsOf: url)
    }

    @Test(arguments: ["usage_2026-10-21", "usage_no_limits", "credentials"])
    func fixtureIsValidJSONObject(name: String) throws {
        let object = try JSONSerialization.jsonObject(with: fixtureData(name))
        #expect(object is [String: Any])
    }

    @Test func usageFixtureHasThreeLimits() throws {
        let object = try #require(
            try JSONSerialization.jsonObject(with: fixtureData("usage_2026-10-21")) as? [String: Any]
        )
        let limits = try #require(object["limits"] as? [[String: Any]])
        #expect(limits.map { $0["kind"] as? String } == ["session", "weekly_all", "weekly_scoped"])
    }

    @Test func noLimitsFixtureHasNoLimitsKey() throws {
        let object = try #require(
            try JSONSerialization.jsonObject(with: fixtureData("usage_no_limits")) as? [String: Any]
        )
        #expect(object["limits"] == nil)
        #expect(object["five_hour"] != nil)
        #expect(object["seven_day"] != nil)
    }
}
