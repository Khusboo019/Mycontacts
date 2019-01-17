//
//  HomeViewController.swift
//  MyContacts
//
//  Created by GLB-311-PC on 12/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var notfoundView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var contactsTableView: UITableView!
    var selectedArray = [ContactsEntity]()
    var isSearchChecked:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addButton.setMakeCircle()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        isSearchChecked=false
       fetchContactsDetails()
    }
    
    func fetchContactsDetails(){
      DatabaseoperationContacts.sharedDatabaseoperationcontacts.fetchAllContacts(completionHandler: {success,contactDBArray in
            if success {
                SingletoneClass.sharedSingletone.contactArray=contactDBArray
            }else{
                print("Failed to fetch data")
            }
            if SingletoneClass.sharedSingletone.contactArray.count > 0{
                contactsTableView.isHidden=false
            }else{
                contactsTableView.isHidden=true
            }
            contactsTableView.reloadData()
        } )
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        searchTextfield.becomeFirstResponder()
    }
    
    
    @IBAction func editingChangedTextfield(_ sender: UITextField) {
        
        if !(Validations.sharedValidation.trimString(validString: sender.text!)).isEmpty {
            isSearchChecked=true
            selectedArray = SingletoneClass.sharedSingletone.contactArray.filter {
                return $0.firstname?.range(of:(Validations.sharedValidation.trimString(validString: sender.text!)), options: .caseInsensitive) != nil
            }
            
        }else{
            isSearchChecked=false
        }
        self.contactsTableView.reloadData()
    }
    
    
    @IBAction func addButtonAction(_ sender: UIButton) {
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let destination = segue.destination as? AddContactsViewController {
                destination.setPrimaryId(val:Int64(SingletoneClass.sharedSingletone.contactArray.count))
                destination.setUpdateType(val: false)
            
          }else if let destination = segue.destination as? ContactDetailsViewController {
            guard let detailsOfContact = sender as? Contacts else { return }
                destination.setContactsDetils(contactDetails:detailsOfContact)
        }
    }
    
    //MARK: UITextfield delegate
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isSearchChecked=true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        isSearchChecked=false
        return true
        
    }
}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchChecked {
           return selectedArray.count
        }
        return SingletoneClass.sharedSingletone.contactArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! contactsTableViewCell
        if isSearchChecked {
            cell.nameLabel.text=selectedArray[indexPath.row].firstname!+" "+selectedArray[indexPath.row].lastname!
            cell.emailLabel.text=selectedArray[indexPath.row].email
            
            cell.profileImageView.image = ImagePickerModel.sharedImagePickerModel.convertToImage(dataImage: selectedArray[indexPath.row].profileimage! as Data)
        }else{
            cell.nameLabel.text=SingletoneClass.sharedSingletone.contactArray[indexPath.row].firstname!+" "+SingletoneClass.sharedSingletone.contactArray[indexPath.row].lastname!
            cell.emailLabel.text=SingletoneClass.sharedSingletone.contactArray[indexPath.row].email
            
            cell.profileImageView.image = ImagePickerModel.sharedImagePickerModel.convertToImage(dataImage: SingletoneClass.sharedSingletone.contactArray[indexPath.row].profileimage! as Data)
        }
        
     
        cell.profileImageView.setMakeCircle()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = Contacts(id:SingletoneClass.sharedSingletone.contactArray[indexPath.row].id, firstname:SingletoneClass.sharedSingletone.contactArray[indexPath.row].firstname,lastname:SingletoneClass.sharedSingletone.contactArray[indexPath.row].lastname,email:SingletoneClass.sharedSingletone.contactArray[indexPath.row].email,mobile:SingletoneClass.sharedSingletone.contactArray[indexPath.row].mobile,profileimage:SingletoneClass.sharedSingletone.contactArray[indexPath.row].profileimage,location:SingletoneClass.sharedSingletone.contactArray[indexPath.row].country)
        
        self.performSegue(withIdentifier: "ContactsDetailsSegue", sender: value)
    }
}
