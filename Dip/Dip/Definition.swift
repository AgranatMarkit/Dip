//
//  Definition.swift
//  Dip
//
//  Created by Ilya Puchka on 04.11.15.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import Foundation

///Internal representation of a key used to associate definitons and factories by tag, type and factory.
struct DefinitionKey : Hashable, Equatable, CustomDebugStringConvertible {
    var protocolType: Any.Type
    var factory: Any.Type
    var associatedTag: DependencyContainer.Tag?
    
    var hashValue: Int {
        return "\(protocolType)-\(factory)-\(associatedTag)".hashValue
    }
    
    var debugDescription: String {
        return "type: \(protocolType), factory: \(factory), tag: \(associatedTag)"
    }
}

func ==(lhs: DefinitionKey, rhs: DefinitionKey) -> Bool {
    return
        lhs.protocolType == rhs.protocolType &&
            lhs.factory == rhs.factory &&
            lhs.associatedTag == rhs.associatedTag
}

///Describes the lifecycle of instances created by container.
public enum ComponentScope {
    /// Indicates that new instance of the component will be always created.
    case Prototype
    /// Indicates that resolved component should be retained by container and always reused.
    case Singleton
}

///Definition of type T describes how instances of this type should be created when they are resolved by container.
public final class DefinitionOf<T>: Definition {
    let factory: Any
    let scope: ComponentScope
    
    init(factory: Any, scope: ComponentScope = .Prototype) {
        self.factory = factory
        self.scope = scope
    }
    
    var resolvedInstance: T? {
        get {
            guard scope == .Singleton else { return nil }
            return _resolvedInstance
        }
        set {
            guard scope == .Singleton else { return }
            _resolvedInstance = newValue
        }
    }
    
    private var _resolvedInstance: T?
}

///Dummy protocol to store definitions for different types in collection
protocol Definition {}
