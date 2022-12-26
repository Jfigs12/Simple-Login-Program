//
//  testingsomemore.swift
//  testing
//
//  Created by Jason Figueiredo on 11/18/22.
//

import Foundation
import SwiftUI
import PythonKit
func runPythonScriptUsernameTest(Username: PythonObject)->PythonObject{
    let sys = Python.import("sys")
    sys.path.append("/Users/jasonfigueiredo/Desktop/testing/testing/")
    let file = Python.import("Python")
    
    
    let response = file.testUsername(Username)
    return response
}

func runPythonScriptPasswordTest(Password: PythonObject)->PythonObject{
    let sys = Python.import("sys")
    sys.path.append("/Users/jasonfigueiredo/Desktop/testing/testing/")
    let file = Python.import("Python")
    
    let response = file.testPassword(Password)
    return response
}
