//
// Created by Douglas Barreto on 06/01/17.
// Copyright (c) 2017 Carrefour Comercio e Industria Ltda. All rights reserved.
//
import Foundation
import KIF
import UIKit

extension KIFUITestActor {
    
    //
    // MARK: Find View
    //
    open func tryFindingViewWith(accessibilityLabel label: String) -> Bool {
        do {
            try self.tryFindingView(withAccessibilityLabel: label, traits: UIAccessibilityTraitNone)
            return true
        } catch _ {
            return false
        }
        
    }
    
    open func tryFindingViewWith(accessibilityIdentifier identifier: String, tappable: Bool = true) -> Bool {
        var view: UIView?
        do {
            try self.wait(for: nil, view: &view, withIdentifier: identifier, tappable: tappable)
        } catch _ {
            return false
        }
        return true
    }
    
    //
    // MARK: Wait for View
    //
    open func waitForViewWith(accessibilityIdentifier identifier: String) -> UIView? {
        return self.waitForTappableViewWith(accessibilityIdentifier: identifier, mustBeTappable: false)
    }
    
    open func waitForTappableViewWith(accessibilityIdentifier identifier: String) -> UIView? {
        return self.waitForTappableViewWith(accessibilityIdentifier: identifier, mustBeTappable: true)
    }
    
    open func waitForTappableViewWith(accessibilityIdentifier identifier: String, mustBeTappable: Bool) -> UIView? {
        var view: UIView?
        self.wait(for: nil, view: &view, withIdentifier: identifier, tappable: mustBeTappable)
        return view
    }
    //swiftlint: disable identifier_name
    func waitForElementWith<T>(accessibilityIdentifier identifier: String, in view: UIView? = nil) -> T {
        
        if let v = view {
            var element: UIAccessibilityElement?
            var view: UIView?
            self.wait(for: &element, view: &view, withIdentifier: identifier, fromRootView: v, tappable: false)
            
            guard let viewFound = view as? T else {
                fatalError("\(identifier) are not \(String(describing: T.self)).")
            }
            
            return viewFound
            
        } else {
            guard let element = self.waitForViewWith(accessibilityIdentifier: identifier) as? T
                else {
                    fatalError("\(identifier) are not \(String(describing: T.self)).")
            }
            return element
        }
    }
    
    //
    // MARK: Tap into View
    //
    open func waitForViewWith(accessibilityLabel label: String, in rootView: UIView? = nil) {
        self.waitForTappableView(withAccessibilityLabel: label)
    }
    open func tapViewWith(accessibilityLabel label: String, in rootView: UIView? = nil) {
        self.tapView(withAccessibilityLabel: label)
    }
    
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
    
    open func tapItem(at indexPath: IndexPath, collection: UIView, withIdentifier identifier: String ) {
        var cell: UIView!
        
        if let tableView = collection as? UIKit.UITableView {
            cell = self.waitForCell(at: indexPath, in: tableView)
        } else if let collectionView = collection as? UIKit.UICollectionView {
            cell = self.waitForCell(at: indexPath, in: collectionView)
        } else {
            assertionFailure("collection should be of type UICollectionView or UITableView")
        }
        
        self.tapViewWith(accessibilityIdentifier: identifier, in: cell)
    }
    
    open func tapItem(at indexPath: IndexPath, collection: UIView) {
        if let tableView = collection as? UIKit.UITableView {
            self.tapRow(at: indexPath, in: tableView)
        } else if let collectionView = collection as? UIKit.UICollectionView {
            self.tapItem(at: indexPath, in: collectionView)
        } else {
            assertionFailure("collection should be of type UICollectionView or UITableView")
        }
    }
    
    //
    // MARK: Long Press into View
    //
    
    open func longPressViewWith(accessibilityIdentifier identifier: String, duration: TimeInterval) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.wait(for: &element, view: &view, withIdentifier: identifier, tappable: true)
        self.longPress(element, in: view, duration: duration)
    }
    
    //
    // MARK: Enter text
    //
    
    open func enter(text: String, intoViewWithAccessibilityIdentifier identifier: String) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.wait(for: &element, view: &view, withIdentifier: identifier, tappable: true)
        self.tapViewWith(accessibilityIdentifier: identifier)
        self.enterText(intoCurrentFirstResponder: text, fallbackView: view)
    }
    
    //
    // MARK: Clear Text
    //
    
    open func clearTextFromViewWith(accessibilityIdentifier identifier: String) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.wait(for: &element, view: &view, withIdentifier: identifier, tappable: true)
        self.clearText(from: element, in: view)
    }
    
    open func replace(text: String, intoViewWithAccessibilityIdentifier identifier: String) {
        self.clearTextFromViewWith(accessibilityIdentifier: identifier)
        self.enter(text: text, intoViewWithAccessibilityIdentifier: identifier)
    }
    
    //
    // MARK: Switer
    //
    
    open func setSwitch(isOn: Bool, intoViewWithAccessibilityIdentifier identifier: String) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.wait(for: &element, view: &view, withIdentifier: identifier, tappable: true)
        
        if let switchView = view as? UISwitch {
            self.setSwitch(switchView, element: element, on: isOn)
        }
    }
    
    //
    // MARK: Slider
    //
    
    func set(value: Float, intoViewWithAccessibilityIdentifier identifier: String) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.wait(for: &element, view: &view, withIdentifier: identifier, tappable: true)
        
        if let slider = view as? UISlider {
            self.setValue(value, for: slider)
        }
    }
    
    //
    // MARK: Swipe into view
    //
    
    open func swipeViewWith(accessibilityIdentifier identifier: String, inDirection direction: KIFSwipeDirection) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.wait(for: &element, view: &view, withIdentifier: identifier, tappable: true)
        self.swipeAccessibilityElement(element, in: view, in: direction)
    }
    
    //
    // MARK: Pull to request
    //
    
    open func pullToRefreshViewWith(accessibilityIdentifier identifier: String) {
        self.pullToRefreshViewWith(accessibilityIdentifier: identifier, pullDownDuration: KIFPullToRefreshTiming.inAboutAHalfSecond)
    }
    
    open func pullToRefreshViewWith(accessibilityIdentifier identifier: String, pullDownDuration: KIFPullToRefreshTiming) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.wait(for: &element, view: &view, withIdentifier: identifier, tappable: true)
        self.pull(toRefreshAccessibilityElement: element, in: view, pullDownDuration: pullDownDuration)
    }
    
    //
    // MARK: Tap Stepper
    //
    open func tapStepperWith(accessibilityIdentifier identifier: String, increment stepperDirection: KIFStepperDirection) {
        var view: UIView?
        var element: UIAccessibilityElement?
        self.wait(for: &element, view: &view, withIdentifier: identifier, tappable: true)
        self.tapStepper(with: element, increment: stepperDirection, in: view)
    }
    
    // MARK: UITableViewCell functions
    
    func waitForCell(at row: Int, section: Int = 0, inTableViewWithAccessibilityIdentifier identifier: String) -> UITableViewCell {
        let indexPath = IndexPath(row: row, section: section)
        
        return waitForCell(at: indexPath, inTableViewWithAccessibilityIdentifier: identifier)
    }
}

