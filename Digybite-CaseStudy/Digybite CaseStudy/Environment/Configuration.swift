//
//  Configuration.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import Foundation
class Configuration {

    class Value { private init(){} }
    class Enums { private init(){} }
}

extension Configuration.Value {
    static var all: [String: Any] {
        return Bundle.main.infoDictionary?["LSEnvironment"] as? [String: Any] ?? [:]
    }
}

extension Configuration.Value {

    private enum Keys: String {
        case environment = "Environment"
        case host = "Host"
        case apiKey = "ApiKey"
    }

    private static func get<T>(value key: Keys, type: T.Type) -> T? {
        return all[key.rawValue] as? T
    }
}

// MARK: - Environment type value

extension Configuration.Enums {
    enum EnvironmentType: String {
        case production = "Production"
        case development = "Development"
    }
}

extension Configuration.Value {
    static var type: Configuration.Enums.EnvironmentType {
        let environment = get(value: .environment, type: String.self)!
        return Configuration.Enums.EnvironmentType(rawValue: environment)!
    }
}

// MARK: - Host (sample with string)

extension Configuration.Value {
    static var host: String { return get(value: .host, type: String.self)! }
    static var apiKey: String { return get(value: .apiKey, type: String.self)! }
}
