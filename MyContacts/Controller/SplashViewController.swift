//
//  ViewController.swift
//  MyContacts
//
//  Created by GLB-311-PC on 12/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
typealias Completionhandler = (_ success:Bool,_ countryFetched:[Countries]) -> Void
    
    @IBOutlet weak var loaderAnimation: Loaderanimation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchCountriesList(completionHandler: {success,countryFetched in
            if success {
                SingletoneClass.sharedSingletone.countryListArray = countryFetched
            }else{
                SingletoneClass.sharedSingletone.countryListArray=[]
                let alert = UIAlertController(title: "Failed", message: "Something went wrong to fetch country list from server", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
            self.performSegue(withIdentifier:"HomeSegue", sender:self)
        })
        
    }
 
    func fetchCountriesList(completionHandler:@escaping Completionhandler){
        loaderAnimation.isHidden=false
        //get homescreen category reponse
        DispatchQueue.global().async {
            APIHelperclass.sharedApiHelperClass.getCountryList(completionHandler:{ (response, error) in
                DispatchQueue.main.async {
                    self.loaderAnimation.isHidden=true
                    if error == nil {
                        completionHandler(true,response!)
                    }else{
                        completionHandler(false,[])
                        print(error ?? "Something went wrong")
                    }
                }
                
            })
        }
        
    }
    
}

