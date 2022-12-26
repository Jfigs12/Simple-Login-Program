//
//  Action After button is tapped.swift
//  testing
//
//  Created by Jason Figueiredo on 11/21/22.
//

import Foundation
import SwiftUI
import PythonKit
import SQLite

func Scorring(Score: PythonObject)->Bool{
    //This litteraly just takes the array and checks the array for the
    //binary 0 or 1 checking for issues in the password and
    //returns false score if the password does not meet criteria
    if(Score.contains(1)){
        return false
    }
    return true
    
}





func buttonTapped(username: PythonObject, password: PythonObject)->(PythonObject){
    //Self explanitory, Runs when button is tapped after input
    //returns back checking if there is anything wrong
    //returns score for logging in to button
    var array: PythonObject = [0,0,0,0,0,0]
    
    let check: Bool = false
    if(String(username) == ""){
        print("Username is empty")
        return PythonObject(check)
    }
    if(String(password) == ""){
        print("Password is empty")
        return PythonObject(check)
        
    }
    array = getArray(username: username, password: password)
    let finalScore = Scorring(Score:array)
    return PythonObject(finalScore)
}

func getArray(username: PythonObject, password: PythonObject)->PythonObject{
    let score1 = runPythonScriptUsernameTest(Username: username)
    let score2 = runPythonScriptPasswordTest(Password: password)
    var array: PythonObject = [0,0,0,0,0,0]
    array[0] = score1[0]
    array[1] = score1[1]
    array[2] = score2[0]
    array[3] = score2[1]
    array[4] = score2[2]
    array[5] = score2[3]
    array = PythonObject(array)
    
    return array
}

func checkLogin(username: PythonObject, password: PythonObject)->checks{
    let check = checkDatabase(username: username, password: password)
    return check
}

func printDatabase(){
    do{
        print("This is whats in the database")
        let db = try Connection("/Users/jasonfigueiredo/Desktop/testing/testing/Users.db")
        for user in try db.prepare(People) {
            print("name: \(String(describing: user[Username])), Password: \(String(describing: user[Password]))")
               // id: 1, name: Optional("Alice"), email: alice@mac.com
           }
    }
    catch{
        print(error)
    }
}
