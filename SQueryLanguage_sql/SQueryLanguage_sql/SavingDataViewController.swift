//
//  SavingDataViewController.swift
//  SQueryLanguage_sql
//
//  Created by Mayurii Gajbhiye on 18/12/19.
//  Copyright © 2019 q. All rights reserved.
//

import UIKit
import SQLite

class SavingDataViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
        
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var emailID: UITextField!
    
    @IBOutlet weak var ID_No: UITextField!
    
    @IBOutlet weak var phoneNo: UITextField!
   
    
    //var dataBaseConnection:Connection!
    var firstN:String = " "
    var lastN:String = " "
    var email:String = " "
    var ID:String = " "
    var phone:String = " "
    var tag:Int!
    var update = [String]()
    
    
    var data1 = [String]()
    var data2 = [String]()
    var data3 = [String]()
    var data4 = [String]()
    var data5 = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//  let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        print(path)
//        do{
//            dataBaseConnection = try Connection("\(path)/employeeDetails.sqlite3")
//            try dataBaseConnection.run("Create table if not exists employeeDetails(ID INTEGER PRIMARY KEY AUTOINCREMENT,FirstName Text,LastName Text,EmailID Text,ID_No Text,PhoneNo Text)")
//        }
//        catch{
//
//            print("Unable to Connect Database")
//        }
//    }
//
               firstName.text = ""
               lastName.text  = ""
               emailID.text = ""
               ID_No.text = ""
               phoneNo.text = ""
        
        do{
            connectToDB.shared.dataBase()
            
          try connectToDB.shared
            .dataBaseConnection.run("Create table if not exists employeeDetails(ID INTEGER PRIMARY KEY AUTOINCREMENT,FirstName Text,LastName Text,EmailID Text,ID_No Text,PhoneNo Text)")
          
        }catch{
            
            print("Unable to Catch the Error")
        }
    }
    

    @IBAction func saveBtnTap(_ sender: Any) {
    
        do{
            
            try connectToDB.shared.dataBaseConnection.run("INSERT INTO employeeDetails(FirstName,LastName,EmailID,ID_No,PhoneNo) values (?,?,?,?,?)", firstName.text! ,lastName.text!, emailID.text!,ID_No.text!,phoneNo.text!)
            
            
        }catch{
    
      print("Unable to Catch the Error")
    
    }
    
  }
  
    
    
    @IBAction func fetchBtn(_ sender: Any) {
     
         do{
//
            
            try connectToDB.shared.dataBaseConnection.run("UPDATE UserDetails SET FirstNam = '\( firstName.text!)',LastName = '\(lastName.text!)',EmailID = '\(phoneNo.text!)',ID_No = '\(ID_No.text!), PhoneNo = '\(phoneNo.text!)'FirstNam = '\(update[tag])'")
                      
            firstName.text = ""
                       lastName.text  = ""
                       emailID.text = ""
                       ID_No.text = ""
                       phoneNo.text = ""
            connectToDB.shared.alert(message: "Updated Successfully")
            present(connectToDB.shared.alertController, animated: true, completion: nil)
            
            
            
         }catch{
     
       print("Unable to Catch the Error")
     
     }
     
   }
    
    
    }

