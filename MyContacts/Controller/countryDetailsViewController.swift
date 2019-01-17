//
//  countryDetailsViewController.swift
//  MyContacts
//
//  Created by GLB-311-PC on 16/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import UIKit


class countryDetailsViewController: UIViewController {

    var delegateCountryDetails : CountryDetailsDelegate!
    @IBOutlet weak var countryListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gestureDismissAction(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectedCountry(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   
}

extension countryDetailsViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletoneClass.sharedSingletone.countryListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for:indexPath)
        cell.layer.cornerRadius=5
        cell.layer.borderWidth=2
        cell.layer.borderColor=UIColor.white.cgColor
        cell.textLabel?.text = SingletoneClass.sharedSingletone.countryListArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegateCountryDetails .setCountryName(selectedCountry: SingletoneClass.sharedSingletone.countryListArray[indexPath.row].name ?? "")
        dismiss(animated: true, completion:nil)
       
    }
}
