//
//  ImagePickerModel.swift
//  MyContacts
//
//  Created by GLB-311-PC on 15/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import Foundation
import Photos

protocol imagePickerModelDelegate:class {
    func updateStatus(success:Bool)
}

class ImagePickerModel:NSObject {
    weak var delegateImagePickerModel:imagePickerModelDelegate?
    static let sharedImagePickerModel = ImagePickerModel()
    var flag=false
    
    //MARK: Check Permission
    func checkPermission() {
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
            
        case .authorized:
            flag=true
            print("Access is granted by user")
            self.delegateImagePickerModel?.updateStatus(success: flag)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    self.flag=true
                    print("success")
                    self.delegateImagePickerModel?.updateStatus(success: self.flag)
                }
            })
            print("It is not determined until now")
        case .restricted:
            flag=false
            print("User do not have access to photo album.")
            self.delegateImagePickerModel?.updateStatus(success: flag)
        case .denied:
            flag=false
            print("User has denied the permission.")
            self.delegateImagePickerModel?.updateStatus(success: flag)
        }
      
    }
    
    func convertToImage(dataImage:Data)->UIImage{
        let image: UIImage = UIImage(data: dataImage) ?? UIImage.init()
        return image
    }

    
        
}
