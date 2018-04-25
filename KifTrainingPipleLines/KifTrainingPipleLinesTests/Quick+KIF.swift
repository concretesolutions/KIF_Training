//
//  Quick+KIF.swift
//  KifTrainingPipleLinesTests
//
//  Created by douglas.barreto on 4/25/18.
//  Copyright © 2018 Douglas Mendes Barreto. All rights reserved.
//

import Quick
import KIF

extension QuickSpec {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }
}

extension KIFUITestActor {
    open func tapViewWith(accessibilityIdentifier identifier: String, in rootView: UIView? = nil) {
        var element: UIAccessibilityElement?
        var view: UIView?
        if let root = rootView {
            self.wait(for: &element, view: &view, withIdentifier: identifier, fromRootView: root, tappable: true)
        } else {
            self.wait(for: &element, view: &view, withIdentifier: identifier, tappable: true)
        }
        self.tap(element, in: view)
    }
    
    open func waitForTappableViewWith(accessibilityIdentifier identifier: String, mustBeTappable: Bool) -> UIView? {
        var view: UIView?
        self.wait(for: nil, view: &view, withIdentifier: identifier, tappable: mustBeTappable)
        return view
    }
}



