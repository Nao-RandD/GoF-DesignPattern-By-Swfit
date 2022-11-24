

let component1 = Component1()
let component2 = Component2()
let component3 = Component3()

let mediator = ConcreteMediator(component1, component2, component3)
print("Client triggers operation A.")
component1.doA()

print("\nClient triggers operation D.")
component2.doD()

print("\nClient triggers operation E.")
component3.doE()


print(mediator)
