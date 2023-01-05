//
//  DelayedOperation.swift
//  Command
//
//  Created by Nao RandD on 2023/01/06.
//

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
