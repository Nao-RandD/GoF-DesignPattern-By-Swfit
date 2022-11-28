//
//  TemplateMethodTests.swift
//  TemplateMethodTests
//
//  Created by Naoyuki Kan on 2022/11/29.
//

import XCTest
@testable import TemplateMethod

protocol AbstractProtocol {
    func templateMethod()

    func baseOperation1()
    func baseOperation2()
    func baseOperation3()

    func requiredOperations1()
    func requiredOperation2()

    func hook1()
    func hook2()
}

extension AbstractProtocol {
    func templateMethod() {
        baseOperation1()
        requiredOperations1()
        baseOperation2()
        hook1()
        requiredOperation2()
        baseOperation3()
        hook2()
    }

    func baseOperation1() {
        print("AbbstractProtocol: 大半の仕事を私が行っている")
    }

    func baseOperation2() {
        print("AbbstractProtocol: しかし私はいくつかの処理オーバーライドできるようにした")
    }

    func baseOperation3() {
        print("AbbstractProtocol: しかし私は大半の仕事を行っている")
    }

    func hook1() {}
    func hook2() {}
}

class ConcreteClass1: AbstractProtocol {
    func requiredOperations1() {
        print("ConcreteClass1: Operation1を実行")
    }

    func requiredOperation2() {
        print("ConcreteClass1: Operation2を実行")
    }

    func hook2() {
        print("ConcreteClass1: Hook2をオーバーライド")
    }
}

class ConcreteClass2: AbstractProtocol {
    func requiredOperations1() {
        print("ConcreteClass2: Operation1を実行")
    }

    func requiredOperation2() {
        print("ConcreteClass2: Operation2を実行")
    }

    func hook1() {
        print("ConcreteClass2: Hook1をオーバーライド")
    }
}

class Client {
    static func clientCode(use object: AbstractProtocol) {
        // ...
        object.templateMethod()
        // ...
    }
}

class TemplateMethidConceptual: XCTestCase {
    func test() {
        print("いくつかのクライアントコードは異なるサブクラスで行える")
        Client.clientCode(use: ConcreteClass1())

        print("いくつかのクライアントコードは異なるサブクラスで行える")
        Client.clientCode(use: ConcreteClass2())
    }
}
