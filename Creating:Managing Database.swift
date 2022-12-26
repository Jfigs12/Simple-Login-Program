//
//  Creating:Managing Database.swift
//  testing
//
//  Created by Jason Figueiredo on 11/21/22.
//

import Foundation
import SwiftUI
import PythonKit
import SQLite
var counter: Int = 0
let Username = Expression<String?>("Username")
let Password = Expression<String?>("Password")
let People = Table("People")
var check = checks(usercheck: false,passcheck: false)
//@State var iteration: Int = 0


func createDatabase(){
    do {
        let db = try Connection("/Users/jasonfigueiredo/Desktop/testing/testing/Users.db")
        
        
        
        if(counter == 0){
            print("Creating Database...")
            let drop = People.drop(ifExists: true)
            try db.run(drop)
            counter = counter + 1
            
            
        
            
        try db.run(People.create { t in
            t.column(Username, unique: true)
            t.column(Password)
        })
        }
    }
    catch{
        print(error)
    }
}

func AddToDatabase(username: PythonObject, password: PythonObject)->Bool{
    do{
        let res = checkDatabase(username: username, password: password)
        if(res.usercheck == true){ //checkpoint
            return false
        }
        let username = String(username)
        let password = String(password)
        let db = try Connection("/Users/jasonfigueiredo/Desktop/testing/testing/Users.db")
        
        let insert = People.insert(Username <- username, Password <- password)
        _ = try db.run(insert)
        print("Succesfully added to database")
    }
    catch{
        print(error)
        return false
    }
    return true
}


func checkDatabase(username: PythonObject, password: PythonObject)->checks{
    do{
        
        let username = String(username)
        let password = String(password)
        
        let db = try Connection("/Users/jasonfigueiredo/Desktop/testing/testing/Users.db")
        for user in try db.prepare(People){
            if(user[Username] == username){
                check.usercheck = true
                print("The result of double checking to look for existing user is \(check.usercheck)")
                if(user[Password] == password){
                    check.passcheck = true
                    return check
                    
                }
                
                
                
            }
            
        }
    }
    catch{
        print(error)
        check.usercheck = true
        check.passcheck = false
    }
    return check
}

