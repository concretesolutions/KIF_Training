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
    public var tester: KIFUITestActor { return tester() }
    public var viewTester: KIFUIViewTestActor { return viewTester() }
    public var system: KIFSystemTestActor { return system() }
    
    private func viewTester(_ file: String = #file, _ line: Int = #line) -> KIFUIViewTestActor {
        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }
    
    private func tester(file: String = #file, _ line: Int = #line) -> KIFUITestActor {
        KIFEnableAccessibility()
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
    
    private func system(file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        KIFEnableAccessibility()
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



