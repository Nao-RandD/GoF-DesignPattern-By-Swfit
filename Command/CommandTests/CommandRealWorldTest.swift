//
//  CommandRealWorldTest.swift
//  CommandTests
//
//  Created by Naoyuki Kan on 2022/12/11.
//

import XCTest
import Foundation

class DelayedOperation: Operation {
    private var delay: TimeInterval

    init(_ delay: TimeInterval = 0) {
        self.delay = delay
    }

    override var isExecuting: Bool {
        get { return _executing }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _executing: Bool = false

    override var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }

    private var _finished: Bool = false

    override func start() {
        guard delay > 0 else {
            _start()
            return
        }
        let deadLine = DispatchTime.now() + delay
        DispatchQueue(label: "").asyncAfter(deadline: deadLine) {
            self._start()
        }
    }

    private func _start() {
        guard !self.isCancelled else {
            print("\(self): operation is canceled")
            self.isFinished = true
            return
        }

        self.isExecuting = true
        self.main()
        self.isExecuting = false
        self.isFinished = true
    }
}

class WindowOperation: DelayedOperation {
    override func main() {
        print("\(self)：Windows are closed via HomeKit.")
    }

    override var description: String { "WindowOperation" }
}

class DoorOperation: DelayedOperation {
    override func main() {
        print("\(self)：Doors are closed via HomeKit.")
    }

    override var description: String { "DoorOperation" }
}

class TaxiOperation: DelayedOperation {
    override func main() {
        print("\(self)：Taxi is ordered via Uber.")
    }

    override var description: String { "TaxiOperation" }
}

final class CommandRealWorldTest: XCTestCase {
    func testCommandRealWorld() {
        prepareTestEnviroment {
            let siri = SiriShortcuts.shared

            print("User: Hey Siri, I am leaving my home")
            siri.perform(.leaveHome)

            print("User: Hey Siri, I am leaving my work in 3 minutes")
            siri.perform(.leaveWork, delay: 3)

            print("User: Hey Siri, I am still working")
            siri.cancel(.leaveWork)
        }
    }
}

extension CommandRealWorldTest {
    struct ExecutionTime {
        static let max: TimeInterval = 5
        static let waiting: TimeInterval = 4
    }

    func prepareTestEnviroment(_ execution: () -> Void) {
        let expectation = self.expectation(description: "Expectation for async operations")

        let deadLine = DispatchTime.now() + ExecutionTime.waiting
        DispatchQueue.main.asyncAfter(deadline: deadLine, execute: { expectation.fulfill() })

        execution()

        wait(for: [expectation], timeout: ExecutionTime.max)
    }
}

class SiriShortcuts {
    static let shared = SiriShortcuts()
    /// Operationを順次実行するQueue
    /// maxConcurrentOperationCountプロパティを設定することで同時に実行できるOperationを調整できる
    private lazy var queue = OperationQueue()

    private init() {}

    enum Action: String {
        case leaveHome
        case leaveWork
    }

    func perform(_ action: Action, delay: TimeInterval = 0) {
        print("Siri: performing \(action)-action\n")
        switch action {
        case .leaveHome:
            add(operation: WindowOperation(delay))
            add(operation: DoorOperation(delay))
        case .leaveWork:
            add(operation: TaxiOperation(delay))
        }
    }

    func cancel(_ action: Action) {
        print("Siri: canceling \(action)-action\n")
        switch action {
        case .leaveHome:
            cancelOperation(with: WindowOperation.self)
            cancelOperation(with: DoorOperation.self)
        case .leaveWork:
            cancelOperation(with: TaxiOperation.self)
        }
    }

    private func cancelOperation(with operationType: Operation.Type) {
        queue.operations.filter { operation in
            return type(of: operation) == operationType
        }.forEach({ $0.cancel() })
    }

    private func add(operation: Operation) {
        queue.addOperation(operation)
    }
}
