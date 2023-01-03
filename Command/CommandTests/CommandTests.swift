//
//  CommandTests.swift
//  CommandTests
//
//  Created by Naoyuki Kan on 2022/12/06.
//

import XCTest
@testable import Command

protocol Command {
    func execute()
}

class SimpleCommand: Command {
    private var payload: String

    init(_ payload: String) {
        self.payload = payload
    }

    func execute() {
        print("SimpleCommand: 私は\(payload)のようなシンプルな表示メソッドを処理できます")
    }
}

class ComplexCommand: Command {
    private var receiver: Receiver

    private var a: String
    private var b: String

    init(_ receiver: Receiver, _ a: String, _ b: String) {
        self.receiver = receiver
        self.a = a
        self.b = b
    }

    func execute() {
        print("ComplexCommand: 複雑な処理はReceiverによって行われる")
        receiver.doSomething(a)
        receiver.doSomethingElse(b)
    }
}

class Receiver {
    func doSomething(_ a: String) {
        print("Receiver: \(a)をする")
    }

    func doSomethingElse(_ b: String) {
        print("Receiver: \(b)もする")
    }
}

class Invoker {
    private var onStart: Command?
    private var onFinish: Command?

    func setOnStart(_ command: Command) {
        onStart = command
    }

    func setOnFinish(_ command: Command) {
        onFinish = command
    }

    func doSomethingImportant() {
        print("Invoker: どなたか私が始めるより前に何かしたいですか？")

        onStart?.execute()

        print("Invoker: ... とても大切な作業を進めます")
        print("Invoker: どなたか私が終える前に何かしたいですか？")

        onFinish?.execute()
    }
}

class CommandConceptural: XCTestCase {
    func test() {
        let invoker = Invoker()
        invoker.setOnStart(SimpleCommand("Say Hi!"))

        let receiver = Receiver()
        invoker.setOnFinish(ComplexCommand(receiver, "Send email", "Save report"))
        invoker.doSomethingImportant()
    }
}
