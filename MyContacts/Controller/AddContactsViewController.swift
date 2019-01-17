//
//  AddContactsViewController.swift
//  MyContacts
//
//  Created by Khusboo Suhasini Preety on 14/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import UIKit
import CoreData

class AddContactsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,imagePickerModelDelegate,CountryDetailsDelegate,UITextFieldDelegate {
   
    @IBOutlet weak var contentViewConstraint: NSLayoutConstraint!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var stackViewConstaint: NSLayoutConstraint!
    @IBOutlet weak var profileImageview: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var selectCountrybutton: UIButton!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lastname: UITextField!
    var primaryId:Int64? = 0
    let imagePicker=UIImagePickerController()
    var detailsContacts = Contacts()
    var isBoolEditContacts:Bool = false
    @IBOutlet weak var addToContact: CustomButton!
    var photoUrlPath:NSData?
    var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate=self
        ImagePickerModel.sharedImagePickerModel.delegateImagePickerModel=self
        if isBoolEditContacts {
            updateUI()
        }
    }
    
    
    @IBAction func cameraButtonAction(_ sender: CustomButton) {
        ImagePickerModel.sharedImagePickerModel.checkPermission()
    }
 
    func updateUI(){
      self.view.layoutIfNeeded()
      addToContact.setTitle("Update Contact", for: .normal)
      firstName.text=detailsContacts.firstname
      lastname.text=detailsContacts.lastname
      email.text=detailsContacts.email
      mobile.text=detailsContacts.mobile
      selectCountrybutton.setTitleColor(UIColor.black, for: .normal)
      selectCountrybutton.setTitle((" "+detailsContacts.location!), for: .normal)
      photoUrlPath=detailsContacts.profileimage!
      profileImageview.image=ImagePickerModel.sharedImagePickerModel.convertToImage(dataImage: detailsContacts.profileimage! as Data)
    }
    
    func setPrimaryId(val:Int64){
        primaryId=val
    }
    
    func setUpdateType(val:Bool){
        isBoolEditContacts=val
    }
    
    func setDetailsContacts(val:Contacts){
        detailsContacts=val
    }
    
    func setCountryName(selectedCountry:String){
        self.view.layoutIfNeeded()
        selectCountrybutton.setTitleColor(UIColor.black, for: .normal)
        selectCountrybutton.setTitle((" "+selectedCountry), for: .normal)
    }
    
    @IBAction func addToContactAction(_ sender: UIButton) {
         self.view.layoutIfNeeded()
         self.view.frame.origin.y=0
         self.activeTextField.resignFirstResponder()
        
        guard (photoUrlPath != nil) else {
            let warn = NSError.profileImageError(404)
            showAlert(msg: warn.localizedDescription, status: "Failed")
            return
        }
        
        guard ((Validations.sharedValidation.trimString(validString: firstName.text ?? "")) != "") else {
            let warn = NSError.firstNameError(404)
            setPlaceholderOfText(textField: firstName, string: warn.localizedDescription)
            return
        }
        
        guard ((Validations.sharedValidation.trimString(validString: lastname.text ?? "")) != "") else {
            let warn = NSError.lastNameError(404)
            setPlaceholderOfText(textField: lastname, string: warn.localizedDescription)
            return
        }
        
        guard (Validations.sharedValidation.isValidEmail(emailStr: email.text ?? "")) else {
            let warn = NSError.emailError(404)
            setPlaceholderOfText(textField: email, string: warn.localizedDescription)
            return
        }
       
        guard (Validations.sharedValidation.validateMobile(value: mobile.text ?? "")) else {
            let warn = NSError.mobileError(404)
            setPlaceholderOfText(textField: mobile, string: warn.localizedDescription)
            return
        }
        
        guard (selectCountrybutton.titleLabel?.text != " Please select your country") else {
            let warn = NSError.countryError(404)
            selectCountrybutton.setTitleColor(UIColor.red, for: .normal)
            selectCountrybutton.setTitle((" "+warn.localizedDescription), for: .normal)
            return
        }
       
        if isBoolEditContacts{
            updateContacts(id: detailsContacts.id ?? 0)
        }else{
            for i in 0..<(SingletoneClass.sharedSingletone.contactArray.count){
                if (Validations.sharedValidation.trimString(validString: firstName.text ?? "")) == SingletoneClass.sharedSingletone.contactArray[i].firstname {
                    setPlaceholderOfText(textField: firstName, string: "Firstname already been used!" )
                    return
                }
            }
            let contactsTable = ContactsEntity(context: CoreDataDBModel.sharedCoredataModel.persistentContainer.viewContext)
            contactsTable.id=primaryId ?? 0
            contactsTable.firstname=Validations.sharedValidation.trimString(validString: firstName.text!)
            contactsTable.lastname=Validations.sharedValidation.trimString(validString: lastname.text!)
            contactsTable.email=Validations.sharedValidation.trimString(validString: email.text!)
            contactsTable.mobile=Validations.sharedValidation.trimString(validString: mobile.text!)
            
            if let img = profileImageview.image {
                let data = img.pngData() as NSData?
                contactsTable.profileimage=data
            }
            
            contactsTable.country=selectCountrybutton.titleLabel?.text
            CoreDataDBModel.sharedCoredataModel.saveContext()
            showAlert(msg: "Successfully saved!", status: "Success")
        }
        
       
    }
    
    func updateContacts(id: Int64){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactsEntity")
        fetchRequest.predicate = NSPredicate(format: "id = '\(id)'")
        let result = try? CoreDataDBModel.sharedCoredataModel.persistentContainer.viewContext.fetch(fetchRequest)
        let resultData = result as! [ContactsEntity]
        
        do
        {
            
            if resultData.count == 1
            {
               
                let objectUpdate = resultData[0]
                //objectUpdate.id=id
                objectUpdate.firstname=Validations.sharedValidation.trimString(validString: firstName.text!)
                objectUpdate.lastname=Validations.sharedValidation.trimString(validString: lastname.text!)
                objectUpdate.mobile=Validations.sharedValidation.trimString(validString: mobile.text!)
                objectUpdate.email=Validations.sharedValidation.trimString(validString: email.text!)
                
                 if let img = profileImageview.image {
                    let data = img.pngData() as NSData?
                    objectUpdate.profileimage=data
                   
                }
                objectUpdate.country=selectCountrybutton.titleLabel?.text
                do{
                    CoreDataDBModel.sharedCoredataModel.saveContext()
                    showAlert(msg: "Successfully updated!", status: "Congratulations")
                    if let img = profileImageview.image {
                        let data = img.pngData() as NSData?
                        let user = Contacts(id: id, firstname: Validations.sharedValidation.trimString(validString: firstName.text!), lastname: Validations.sharedValidation.trimString(validString: lastname.text!), email: Validations.sharedValidation.trimString(validString: email.text!), mobile: Validations.sharedValidation.trimString(validString: mobile.text!), profileimage: data, location: selectCountrybutton.titleLabel?.text)
                        
                        NotificationCenter.default.post(name: Notification.Name("updateContactDetails"), object:self, userInfo: user.dictionaryRepresentation)
                        
                    }
                    
                    
                    
                }
            }
        }
        
    }
    
    
    func setPlaceholderOfText(textField:UITextField,string:String){
        textField.text=""
        textField.attributedPlaceholder = NSAttributedString(string:string,
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
    func showAlert(msg:String,status:String){
        let alert = UIAlertController(title: status, message:msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: {
            if status=="Success"{
                self.resetUI()
            }
        })
    }
    
    func resetUI(){
        profileImageview.image=UIImage(named: "userImage")
        photoUrlPath=nil
        firstName.text=""
        lastname.text=""
        mobile.text=""
        email.text=""
        selectCountrybutton.setTitleColor(UIColor.lightGray, for: .normal)
        selectCountrybutton.setTitle(" Please select your country", for: .normal)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func countryDetails(_ sender: CustomButton) {
        self.view.layoutIfNeeded()
        self.view.frame.origin.y=0
        self.activeTextField.resignFirstResponder()
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "countrySegue"{
            if let destination = segue.destination as? countryDetailsViewController {
                destination.delegateCountryDetails=self
            }
        }
    }
    
    func updateStatus(success: Bool) {
        
        if success {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Please allow us to access your photos", message: "Application needs to access your photos library to update profile picture", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Go to setting", style: UIAlertAction.Style.default, handler: { action in
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
           
        }
    }
   
        
    // MARK: - UIImagePickerControllerDelegate Methods
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image.pngData()! as NSData
            data.write(toFile: localPath!, atomically: true)
            
            let photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
            print(photoURL)
            photoUrlPath=data
            profileImageview.image=image
        }
           // Dismiss the picker.
          dismiss(animated: true, completion: nil)
    }
    
    //MARK:Textfield delegates
    
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
       self.activeTextField = textField
       self.view.frame.origin.y = -200
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.frame.origin.y=0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
}


