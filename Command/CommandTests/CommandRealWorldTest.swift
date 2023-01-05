//
//  CommandRealWorldTest.swift
//  CommandTests
//
//  Created by Naoyuki Kan on 2022/12/11.
//

import XCTest
import Foundation
@testable import Command


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
