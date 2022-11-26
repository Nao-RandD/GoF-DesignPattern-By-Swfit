//
//  RealCompositeTests.swift
//  CompositeTests
//
//  Created by Naoyuki Kan on 2022/11/26.
//

import XCTest
import UIKit

//protocol RealComponent {
//    func accept<T: Theme>(theme: T)
//}
//
//extension RealComponent where Self: UIViewController {
//    func accept<T: Theme>(theme: T) {
//        view.accept(theme: theme)
//        view.subviews.forEach({ $0.accept(theme: theme) })
//    }
//}
//
//extension UIView: RealComponent {}
//extension UIViewController: RealComponent {}
//
//extension RealComponent where Self: UIView {
//    func accept<T: Theme>(theme: T) {
//        print("\(description)：に\(theme.description)を適用")
//
//        backgroundColor = theme.backgroundColor
//    }
//}
//
//extension RealComponent where Self: UILabel {
//    func accept<T: LabelTheme>(theme: T) {
//        print("\(description)：に\(theme.description)を適用")
//
//        backgroundColor = theme.backgroundColor
//        textColor = theme.textColor
//    }
//}
//
//extension RealComponent where Self: UIButton {
//    func accept<T: ButtonTheme>(theme: T) {
//        print("\(description)：に\(theme.description)を適用")
//
//        backgroundColor = theme.backgroundColor
//        setTitleColor(theme.textColor, for: .normal)
//        setTitleColor(theme.highlightedColor, for: .highlighted)
//    }
//}
//
//protocol Theme: CustomStringConvertible {
//    var backgroundColor: UIColor { get }
//}
//
//protocol ButtonTheme: Theme {
//    var textColor: UIColor { get }
//    var highlightedColor: UIColor { get }
//}
//
//protocol LabelTheme: Theme {
//    var textColor: UIColor { get }
//}
//
//struct DefaultButtonTheme: ButtonTheme {
//    var textColor = UIColor.red
//    var highlightedColor = UIColor.white
//    var backgroundColor = UIColor.orange
//    var description: String { return "Default Button Theme" }
//}
//
//struct NightButtonTheme: ButtonTheme {
//    var textColor = UIColor.white
//    var highlightedColor = UIColor.red
//    var backgroundColor = UIColor.black
//    var description: String { return "Night Button Theme" }
//}
//
//struct DefaultLabelTheme: LabelTheme {
//    var textColor = UIColor.red
//    var backgroundColor = UIColor.orange
//    var description: String { return "Default Label Theme" }
//}
//
//struct NightLabelTheme: LabelTheme {
//    var textColor = UIColor.white
//    var highlightedColor = UIColor.red
//    var backgroundColor = UIColor.black
//    var description: String { return "Night Label Theme" }
//}
//
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
//
//class WelcomeViewController: UIViewController {
//    class CntentView: UIView {
//        var titleLabel = UILabel()
//        var actionButton = UIButton()
//
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//            setup()
//        }
//
//        required init?(coder decoder: NSCoder) {
//            super.init(coder: decoder)
//        }
//
//        func setup() {
//            addSubview(titleLabel)
//            addSubview(actionButton)
//        }
//
//        override func loadView() {
//            view = ContentView()
//        }
//    }
//}
//
//extension WelcomeViewController {
//    open
//}
