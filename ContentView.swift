//
//  ContentView.swift
//  testing
//
//  Created by Jason Figueiredo on 11/18/22.
//
import PythonKit
import SwiftUI

struct checks{
    var usercheck: Bool = false
    var passcheck: Bool = false
}
struct SecureTextField: View {
    
    @State var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField("Password ", text: $text)
            } else {
                TextField("Password ", text: $text)
            }
        }.overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash": "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
    }
}


struct ContentView: View {
    //Variable Declerations for what will be utilized later
   
    
    @State var username: String = ""
    @State var Password: String = ""
    @State var visibility: Bool = true
    @State var test: String = ""
    @State var score1: PythonObject = 0
    @State var res: Bool = false
    @State var showingPopover: Bool = false
    @State var array: PythonObject = [0,0,0,0,0,0]
    @State var output: Array = ["Username Requires 5 Characters!",
                                "Username Requires 1 Number!",
                                "Password requires 8 Characters",
                                " Password requires one digit",
                                "Password Requires one Upper case letter!",
                                "Password requires one Special Character!"]
    @State var repeatUsername: Bool = false
    @State var repeatUsernameWithoughPassword: Bool = false
    @State var testingImage: Bool = false
    @State var isLoggedIn: Bool = false
    @State var Check1: Bool = false
    @State var Check = checks()
    @State var tester: Bool = false
    @State var toggle: Bool = false
    @State var Res: Bool = false
    
    
    
    var body: some View {
        
        VStack {
            
            if(testingImage == true){
                Image(systemName: "lock.open")
                    .resizable(resizingMode: .stretch)
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.accentColor)
                    .padding([.leading, .bottom]).frame(width: 60.0, height: 60)
            }else{
                Image(systemName: "exclamationmark.lock.fill")
                    .resizable(resizingMode: .stretch)
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.accentColor)
                    .padding([.top, .leading, .bottom]).frame(width: 40.0, height: 40)
            }
            
            Text("Please Input the Following")
                .multilineTextAlignment(.center)
                .padding([.leading, .bottom])
            Form{
                TextField("Username",text:$username)
                    .padding(.leading)
                    .frame(width: 300.0).cornerRadius(40)
            }
            Form{
                //SecureField("Password ", text:$Password).padding(.leading).frame(width: 300.0).cornerRadius(40)
                SecureTextField(text:$Password).padding(.leading).frame(width: 300.0).cornerRadius(40)
                
                
            }
            
            Button("Sign In") {
                createDatabase()
                
                let username = PythonObject(username)
                let Password = PythonObject(Password)
                let Array = getArray(username: username, password: Password)
                array[0] = Array[0]
                array[1] = Array[1]
                array[2] = Array[2]
                array[3] = Array[3]
                array[4] = Array[4]
                array[5] = Array[5]
                Check = checkLogin(username: username, password: Password)
                print("This is the array inside of contentview\(array)")
                score1 = buttonTapped(username: username,password: Password )
                print("Login Score is \(score1) ")
                if(score1 == true){
                    Res = AddToDatabase(username: username, password: Password)
                    print(String(Res))
                    res = true
                }
                else if(score1 == false){
                    //If Loggin Score == False and does not meet criteria
                    //it Sets "res"(Result) to true for "Popover"  to be activate
                    res = true
                    print(String(res))
                    if(Check.usercheck == true && Check.passcheck == false){
                        repeatUsername = true
                    }
                    
                }
                
                
                
                print(String(Check.usercheck))
                //^^Above checks if the user name is repeated
                //if repeated it triggers an error
                //Still requires improvemtnt and finsishing
                
                
                
                if(Check.usercheck == true){
                    
                    if(Check.usercheck == true && Check.passcheck == true){
                        Check1 = true
                    }
                    if(Check.usercheck == true && Check.passcheck == false){
                        Check1 = false
                        //This username already exists if gets here
                    }
                    
                
                    if(Check1 == true){
                        testingImage = true
                        repeatUsernameWithoughPassword = false//
                        res = true
                        
                    }
                    else if(Check.usercheck == true && Check.passcheck == false){
                        repeatUsernameWithoughPassword = true
                    }
                }
                
                
                
                
            }.popover(isPresented: $res,arrowEdge: .bottom)
            {
                //if the "Popover" is summuned, it will
                //loop through all of the possible reasons and
                //Display the reason that it was called or the
                //Invalid imput
                if(repeatUsernameWithoughPassword == false && Check.usercheck == true){
                Text("Log In Succesful!")
                }; if(Res == false && Check.usercheck == false && score1 == true){
                    Text("You where Succesfully added!")
                }; if(repeatUsernameWithoughPassword == true){
                    Text("This Username is already in use!")
                };if(Int(array[0]) == 1){
                    Text(output[0])
                }; if(Int(array[1]) == 1){
                    Text(output[1])
                }; if(Int(array[2]) == 1){
                    Text(output[2])
                }; if(Int(array[3]) == 1){
                    Text(output[3])
                }; if(Int(array[4]) == 1){
                    Text(output[4])
                }; if(Int(array[5]) == 1){
                    Text(output[5])
                };
            }
            .frame(width: 200, height: 40, alignment: .center)}
        .keyboardShortcut(.defaultAction)
        .cornerRadius(30).padding(.top).font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/).bold()
        .buttonStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Button Style@*/DefaultButtonStyle()/*@END_MENU_TOKEN@*/)
        
       
        Button("Print Database"){
            printDatabase()
            
        }
        
        
    }
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            
            ContentView()
        }
    }
    
}
