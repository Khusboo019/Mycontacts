//
//  ContactDetailsViewController.swift
//  MyContacts
//
//  Created by GLB-311-PC on 15/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    var detailsContacts = Contacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateContactDetails(notification:)), name: Notification.Name("updateContactDetails"), object: nil)
    }
    
   
    func setContactsDetils(contactDetails:Contacts){
        detailsContacts=contactDetails
    }
    
    @objc func updateContactDetails(notification: Notification) {
        
        setContactsDetils(contactDetails:Contacts(id: notification.userInfo!["id"] as? Int64, firstname: notification.userInfo!["firstname"] as? String, lastname: notification.userInfo!["lastname"] as? String, email: notification.userInfo!["email"] as? String, mobile: notification.userInfo!["mobile"] as? String, profileimage: notification.userInfo!["profileimage"] as? NSData, location: notification.userInfo!["location"] as? String))
    }
    
    func updateUI(){
        fullName.text = detailsContacts.firstname! + " " + detailsContacts.lastname!
        emailTextfield.text = detailsContacts.email
        mobileTextField.text = detailsContacts.mobile
        locationTextfield.text = detailsContacts.location
        profileImageView.image = ImagePickerModel.sharedImagePickerModel.convertToImage(dataImage: detailsContacts.profileimage! as Data)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier:"updateContactsSegue", sender:detailsContacts)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddContactsViewController {
            destination.setUpdateType(val: true)
            destination.setDetailsContacts(val: detailsContacts)
        }
    }
}
