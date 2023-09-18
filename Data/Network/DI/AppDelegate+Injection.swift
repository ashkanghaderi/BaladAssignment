//
//  AppDelegate+Injection.swift
//  Data
//
//  Created by Ashkan Ghaderi on 2022-02-03.
//

import Foundation
import Resolver

extension Resolver:ResolverRegistering{
    // new injections should be added here
    public static func registerAllServices() {
        ServiceInjection()
    }
    
}

// MARK: SHOULD deleted after swift 5.1
@propertyWrapper
public struct Injected<Service> {
    private var service: Service
    public init() {
        self.service = Resolver.resolve(Service.self)
    }
    public init(name: Resolver.Name? = nil, container: Resolver? = nil) {
        self.service = container?.resolve(Service.self, name: name) ?? Resolver.resolve(Service.self, name: name)
    }
    public var wrappedValue: Service {
        get { return service }
        mutating set { service = newValue }
    }
    public var projectedValue: Injected<Service> {
        get { return self }
        mutating set { self = newValue }
    }
}

@propertyWrapper
struct LazyInjected<Service> {
    private var service: Service!
    public var container: Resolver?
    public var name: Resolver.Name?
    public init() {}
    public init(name: Resolver.Name? = nil, container: Resolver? = nil) {
        self.name = name
        self.container = container
    }
    public var wrappedValue: Service {
        mutating get {
            if self.service == nil {
                self.service = container?.resolve(Service.self, name: name) ?? Resolver.resolve(Service.self, name: name)
            }
            return service
        }
        mutating set { service = newValue  }
    }
    public var projectedValue: LazyInjected<Service> {
        get { return self }
        mutating set { self = newValue }
    }
}
