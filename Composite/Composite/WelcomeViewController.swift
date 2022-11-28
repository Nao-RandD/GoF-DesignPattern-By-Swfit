//
//  WelcomeViewController.swift
//  Composite
//
//  Created by Naoyuki Kan on 2022/11/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    class ContentView: UIView {
        var titleLabel = UILabel()
        var actionButton = UIButton()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        required init?(coder decoder: NSCoder) {
            super.init(coder: decoder)
        }

        func setup() {
            backgroundColor = .white
            titleLabel.text = "タイトル"
            actionButton.setTitle("ボタン", for: .normal)

            apply(theme: DefaultButtonTheme(), for: actionButton)
            apply(theme: DefaultButtonTheme(), for: titleLabel)

//            apply(theme: NightButtonTheme(), for: actionButton)
//            apply(theme: NightLabelTheme(), for: titleLabel)

            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
            titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
            actionButton.translatesAutoresizingMaskIntoConstraints = false
            actionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
            actionButton.heightAnchor.constraint(equalToConstant: 100).isActive = true

            let baseStackView = UIStackView(arrangedSubviews: [titleLabel, actionButton])
            baseStackView.axis = .vertical
            baseStackView.distribution = .equalSpacing
            baseStackView.spacing = 10
            baseStackView.translatesAutoresizingMaskIntoConstraints = false

            addSubview(baseStackView)

            [baseStackView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
             baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -300),
             baseStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
             baseStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            ].forEach { $0.isActive = true }
        }

        func apply<T: Theme>(theme: T, for component: RealComponent) {
            component.accept(theme: theme)
        }
    }

    func apply<T: Theme>(theme: T, for component: RealComponent) {
        component.accept(theme: theme)
    }

    override func loadView() {
        view = ContentView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
    }

}

extension WelcomeViewController {
    open override var description: String { return "WelcomeViewController" }
}

extension WelcomeViewController.ContentView {
    override var description: String { return "ContentView" }
}

extension UIButton {
    open override var description: String { return "UIButton" }
}

extension UILabel {
    open override var description: String { return "UILabel" }
}

protocol RealComponent {
    func accept<T: Theme>(theme: T)
}

extension RealComponent where Self: UIViewController {
    func accept<T: Theme>(theme: T) {
        view.accept(theme: theme)
        view.subviews.forEach({ $0.accept(theme: theme) })
    }
}

extension UIView: RealComponent {}
extension UIViewController: RealComponent {}

extension RealComponent where Self: UIView {
    func accept<T: Theme>(theme: T) {
        print("\(description)：に\(theme.description)を適用")

        backgroundColor = theme.backgroundColor
    }
}

extension RealComponent where Self: UILabel {
    func accept<T: LabelTheme>(theme: T) {
        print("\(description)：に\(theme.description)を適用")

        backgroundColor = theme.backgroundColor
        textColor = theme.textColor
    }
}

extension RealComponent where Self: UIButton {
    func accept<T: ButtonTheme>(theme: T) {
        print("\(description)：に\(theme.description)を適用")

        backgroundColor = theme.backgroundColor
        setTitleColor(theme.textColor, for: .normal)
        setTitleColor(theme.highlightedColor, for: .highlighted)
    }
}

protocol Theme: CustomStringConvertible {
    var backgroundColor: UIColor { get }
}

protocol ButtonTheme: Theme {
    var textColor: UIColor { get }
    var highlightedColor: UIColor { get }
}

protocol LabelTheme: Theme {
    var textColor: UIColor { get }
}

struct DefaultButtonTheme: ButtonTheme {
    var textColor = UIColor.red
    var highlightedColor = UIColor.white
    var backgroundColor = UIColor.orange
    var description: String { return "Default Button Theme" }
}

struct NightButtonTheme: ButtonTheme {
    var textColor = UIColor.white
    var highlightedColor = UIColor.red
    var backgroundColor = UIColor.black
    var description: String { return "Night Button Theme" }
}

struct DefaultLabelTheme: LabelTheme {
    var textColor = UIColor.red
    var backgroundColor = UIColor.orange
    var description: String { return "Default Label Theme" }
}

struct NightLabelTheme: LabelTheme {
    var textColor = UIColor.white
    var highlightedColor = UIColor.red
    var backgroundColor = UIColor.black
    var description: String { return "Night Label Theme" }
}

//class CompositeRealWorld: XCTestCase {
//    func testCompositeRealWorld() {
//        print("クライアント側でデフォルトのUIButtonのテーマを適用")
//        apply(theme: DefaultButtonTheme(), for: UIButton())
//
//        print("クライアント側で夜のUIButtonのテーマを適用")
//        apply(theme: DefaultButtonTheme(), for: UIButton())
//
//        print("クライアントでViewControllerを利用していこう")
//
//        // 夜のテーマ
//
//    }
//
//    func apply<T: Theme>(theme: T, for component: RealComponent) {
//        component.accept(theme: theme)
//    }
//}
