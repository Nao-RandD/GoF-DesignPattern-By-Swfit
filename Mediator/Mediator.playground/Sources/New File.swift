import Foundation

/// The Mediator interface declares a method used by components to notify the
/// mediator about various events. The Mediator may react to these events and
/// pass the execution to other components.
public protocol Mediator: AnyObject {

    func notify(sender: BaseComponent, event: String)
}

/// Concrete Mediators implement cooperative behavior by coordinating several
/// components.
public class ConcreteMediator: Mediator {

    private var component1: Component1
    private var component2: Component2
    private var component3: Component3

    public init(_ component1: Component1, _ component2: Component2, _ component3: Component3) {
        self.component1 = component1
        self.component2 = component2
        self.component3 = component3

        component1.update(mediator: self)
        component2.update(mediator: self)
        component3.update(mediator: self)
    }

    public func notify(sender: BaseComponent, event: String) {
        if event == "A" {
            print("Mediator reacts on A and triggers following operations:")
            self.component2.doC()
        } else if (event == "D") {
            print("Mediator reacts on D and triggers following operations:")
            self.component1.doB()
            self.component2.doC()
        } else if (event == "E") {
            print("Mediator reacts on E and triggers following operetions:")
            self.component3.doE()
            self.component2.doC()
            self.component3.doF()
        }
    }
}

/// The Base Component provides the basic functionality of storing a mediator's
/// instance inside component objects.
public class BaseComponent {
    fileprivate weak var mediator: Mediator?

    public init(mediator: Mediator? = nil) {
        self.mediator = mediator
    }

    public func update(mediator: Mediator) {
        self.mediator = mediator
    }
}

public class Component1: BaseComponent {
    public init(){}

    public func doA() {
        print("Component 1 does A.")
        mediator?.notify(sender: self, event: "A")
    }

    public func doB() {
        print("Component 1 does B.\n")
        mediator?.notify(sender: self, event: "B")
    }
}

public class Component2: BaseComponent {
    public init(){}

    public func doC() {
        print("Component 2 does C.")
        mediator?.notify(sender: self, event: "C")
    }

    public func doD() {
        print("Component 2 does D.")
        mediator?.notify(sender: self, event: "D")
    }
}

public class Component3: BaseComponent {
    public init() {}

    public func doE() {
        print("Component 3 does E")
        mediator?.notify(sender: self, event: "E")
    }

    public func doF() {
        print("Component 4 does F")
        mediator?.notify(sender: self, event: "F")
    }
}

