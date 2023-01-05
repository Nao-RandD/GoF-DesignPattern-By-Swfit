//
//  WindowOperation.swift
//  Command
//
//  Created by Nao RandD on 2023/01/06.
//

import Foundation

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
