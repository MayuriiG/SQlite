//
//  ViewController.swift
//  SQueryLanguage_sql
//
//  Created by Mayurii Gajbhiye on 18/12/19.
//  Copyright © 2019 q. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    
    @IBOutlet weak var stackView: UIStackView!
    
      var firstName = [String]()
      var lastName = [String]()
      var emailID = [String]()
      var ID_no = [String]()
      var phoneNo = [String]()
    
    var details:String = " "
    var deleteBtn =  [UIButton]()
    var allbutton = [UIButton]()
    var dataStored = [String]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        for x in allbutton{

            x.removeFromSuperview()
        }
        for x in deleteBtn{
            x.removeFromSuperview()
        }
        
        
        allbutton = [UIButton]()
        deleteBtn = [UIButton]()
        dataStored = [String]()
        firstName = [String]()
        lastName = [String]()
        emailID = [String]()
        ID_no = [String]()
        phoneNo = [String]()
        
        
        connectToDB.shared.dataBase() //RETREVING DATA
        do{
           var value:Int = 0
           // connectToDB.shared.dataBase()
            
        let stmt = try connectToDB.shared.dataBaseConnection.run("SELECT FirstName,LastName,EmailID,ID_No,PhoneNo from employeeDetails")
            
        for row in stmt{
          
            details = " "
               
        for (index,name) in stmt.columnNames.enumerated(){
                    print("\(name):\(row[index]!)")

            if (index == 0){
                firstName.append("\(row[index]!)")
                dataStored.append("\(row[index]!)")
                }
            
            if (index == 1){
                lastName.append("\(row[index]!)")
                }
                    
            if (index == 2){
                emailID.append("\(row[index]!)")
                }
            if (index == 3){
                ID_no.append("\(row[index]!)")
                }
            if (index == 4){
                phoneNo.append("\(row[index]!)")
                }
            
            details = details + "\n" + ("\(name):\(row[index]!)")

            }
      
             let button  = UIButton()
                button.setTitle(details, for: UIControl.State.normal)
                button.tag = value
                button.titleLabel?.textAlignment = .left
                button.titleLabel?.numberOfLines = 0
                allbutton.append(button)
                button.addTarget(self, action: #selector(navigationToNxtVC(sender:)), for: UIControl.Event.touchUpInside)
        
                button.translatesAutoresizingMaskIntoConstraints = false
                button.widthAnchor.constraint(equalToConstant: 180).isActive = true
                button.heightAnchor.constraint(equalToConstant: 150).isActive = true
                
            let button1 = UIButton()
                let displayImages  = UIImage(named: "deleteOne")
                button1.setImage(displayImages, for: UIControl.State.normal)
                button1.tag =  value
                value = value + 1
                deleteBtn.append(button1)
                button1.addTarget(self, action: #selector(deleteSelectedNames(sender: )), for: UIControl.Event.touchUpInside)
            button1.translatesAutoresizingMaskIntoConstraints = false
            button1.widthAnchor.constraint(equalToConstant: 180).isActive = true
            button1.heightAnchor.constraint(equalToConstant: 150).isActive = true
                
       //error-      let stackView = UIStackView(arrangedSubviews: button)
                //stackView.alig
    let stackaView = UIStackView(arrangedSubviews: [button])
                stackView.alignment = .leading
    let stackaView2 = UIStackView(arrangedSubviews: [button1])
            
      let stackaView3 = UIStackView(arrangedSubviews: [stackaView,stackaView2])
                stackView.addArrangedSubview(stackaView3)
       
            
            }
            
            
        }catch{
            
            print("Unable to Ger data")
            
            
        }
    }
    
    @objc func  navigationToNxtVC(sender:UIButton){
      //  present method block the back button in navigation controller
let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "userDetails")
        as!SavingDataViewController

//        var firstN:String = " "
//        var lastN:String = " "
//        var email:String = " "
//        var ID:String = " "
//        var phone:String = " "
//        var tag:Int!
//        var update = [String]()

        nextVC.firstN  = self.firstName[sender.tag]
        nextVC.lastN  = self.lastName[sender.tag]
        nextVC.email  = self.emailID[sender.tag]
        nextVC.ID  = self.ID_no[sender.tag]
        nextVC.phone = self .phoneNo[sender.tag]
    
        nextVC.update = self.dataStored
        nextVC.tag =  sender.tag
          
//          var data1 = [String]()
//          var data2 = [String]()
//          var data3 = [String]()
//          var data4 = [String]()
//          var data5 = [String]()
//
        nextVC.data1 = self.firstName
        nextVC.data2 = self.lastName
        nextVC.data3 = self.emailID
        nextVC.data4 = self.ID_no
        nextVC.data5 = self.phoneNo

        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
  @objc func deleteSelectedNames(sender:UIButton){

        allbutton[sender.tag].removeFromSuperview()
        deleteBtn[sender.tag].removeFromSuperview()
        
// Removes All "Contact-buttons" and "delete-Button" from viewController
      
        let dataToBeRemoved  =  dataStored[sender.tag]
        
         do{
            try connectToDB.shared.dataBaseConnection.run("delete from employeeDetails where Firstname = '\(dataToBeRemoved)'")  // //sql query for deleting the data)
         
          }catch{
                  print("Something Went Wrong - Error Occurs")
          }
     
    connectToDB.shared.alert(message: "deleted succesfully")
    present(connectToDB.shared.alertController, animated: true, completion: nil)
        
        }
        
   }


    
    

