//
//  HomeViewControllerSpec.swift
//  KifTrainingPipleLinesTests
//
//  Created by douglas.barreto on 4/25/18.
//  Copyright © 2018 Douglas Mendes Barreto. All rights reserved.
//

import Quick
import Nimble
import KIF
import UIKit

@testable import KifTrainingPipleLines

final class HomeViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("HomeViewController") {
            context("when home instantiated") {
                var homeViewController: HomeViewController!
                beforeEach {
                    homeViewController = UIStoryboard(name: "Main", bundle: Bundle(for: HomeViewController.self)).instantiateInitialViewController() as! HomeViewController
                    UIApplication.shared.keyWindow!.rootViewController = homeViewController
                    UIApplication.shared.keyWindow!.makeKeyAndVisible()
                }
            }
            
            it("should show root view controller") {
                self.tester().waitForTappableViewWith(accessibilityIdentifier: "screen_1_button_next_creen", mustBeTappable: true)
            }
        }
    }
}
