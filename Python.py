
import re
import sqlite3



class Password:
    def __init__(self, Password, passleng):
        self.Password = Password
        self.passleng = passleng
class Username:
    def __init__(self, Username,Userlen):
        self.Username = Username
        self.Userlen = Userlen
class account:
    def __init__(self, Password, Username):
        self.Username = Usernames
        self.Password = Password









def testPassword(Password):
    passArr = [0,0,0,0]
    regex = re.compile('[@_!#$%^&*()<>?/\|}{~:]')
    a = 0
    passleng = len(Password)
    if passleng < 8:
        print("Password Needs to be at least 8 Characters Long!")
        passArr[0] = 1
    else:
        a+=1

    res = any(chr.isdigit() for chr in Password)
    if res == False:
        print("Password Requires at least one Digit!!")
        passArr[1] = 1
    else:
        a+=1

    res1 = any(chr.isupper() for chr in Password)
    if res1 == False:
        print("Password Requires Uppercase Letter!")
        passArr[2] = 1
    else:
        a+=1


    if regex.search(Password) == None:
        print("Password Requires a Special Character!")
        passArr[3] = 1
    else:
        a+=1
    

    return passArr

def testUsername(Username):
    userArr = [0,0]
  
    a = 0
    userlen = len(Username)
    #re-add Username.userlen because of class
    if Username == None:
        exit()
   
    if userlen < 5:
        print("Username needs to be at least 5 Characters!")
        userArr[0] = 1
    else:
        a+=1
        
    #Same thing here as in userlen, Username.username
    resUser = any(chr.isdigit() for chr in Username)
    if resUser == False:
        print("Username must have at least one number!")
        userArr[1] = 1
    else:
        a+=1
        
        
   
    return userArr

def createAccount(Password, Username):
    minpoint = 6
    a = testUsername(Username)
    print("")
    print("")
    b = testPassword(Password)

    if a + b != minpoint:
        print("Please Re-Enter")
        return 0



    

    

if __name__  == "__main__":
    main()





