//
//  CompositeTests.swift
//  CompositeTests
//
//  Created by Naoyuki Kan on 2022/11/24.
//

import XCTest
@testable import Composite

protocol Component {
    var parent: Component? { get set }

    func add(component: Component)
    func remove(component: Component)
    func isComposite() -> Bool
    func operation() -> String
}

extension Component {
    func add(component: Component) {}
    func remove(component: Component) {}
    func isComposite() -> Bool {
        return false
    }
}

class Leaf: Component {
    var parent: Component?

    func operation() -> String {
        return "Leaf"
    }
}

class Composite: Component {
    var parent: Component?

    private var children = [Component]()

    func add(component: Component) {
        var item = component
        item.parent = self
        children.append(item)
    }

    func remove(componet: Component) {
        // ...
    }

    func operation() -> String {
        let result = children.map({ $0.operation() })
        return "Branch(\(result.joined(separator: " ")))"
    }
}

class Client {
    static func someClientCode(component: Component) {
        print("Result: \(component.operation())")
    }

    static func moreComplexClientCode(leftComponent: Component, rightComponent: Component) {
        if leftComponent.isComposite() {
            leftComponent.add(component: rightComponent)
        }
        print("Result: \(leftComponent.operation())")
    }
}

class CompositeConceptual: XCTestCase {
    func testCompositeConceptual() {
        print("Client: I've got a simple component:")
        Client.someClientCode(component: Leaf())

        let tree = Composite()

        let branch1 = Composite()
        branch1.add(component: Leaf())
        branch1.add(component: Leaf())

        let branch2 = Composite()
        branch2.add(component: Leaf())
        branch2.add(component: Leaf())

        tree.add(component: branch1)
        tree.add(component: branch2)

        print("composite treeを手に入れた")
        Client.someClientCode(component: tree)

        print("componentクラスをチェックする必要がない")
        Client.moreComplexClientCode(leftComponent: tree, rightComponent: Leaf())
    }
}
