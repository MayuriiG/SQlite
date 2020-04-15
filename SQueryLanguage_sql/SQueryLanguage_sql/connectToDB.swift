//
//  connectToDB.swift
//  SQueryLanguage_sql
//
//  Created by Mayurii Gajbhiye on 21/12/19.
//  Copyright © 2019 q. All rights reserved.
//

import UIKit
import SQLite


//Single ton...............
class connectToDB: NSObject {

    var dataBaseConnection:Connection!
    var alertController:UIAlertController!
    
    static var shared:connectToDB = connectToDB()
    
    
    private override init()
    {
        
        super.init()
    }
    
    
    func dataBase(){
        
        
        let path =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(path)
        
        do{
            dataBaseConnection = try Connection("\(path)/employeeDetails.sqlite3")
            
            
        }catch{
            
            print("Unable to Retrive data")

        }
        
    }
    
    func alert(message:String){
        alertController = UIAlertController(title: "", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        let button  = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil)
        
        alertController.addAction(button)
        
    }
    
}
