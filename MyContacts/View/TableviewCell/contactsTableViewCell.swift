//
//  contactsTableViewCell.swift
//  MyContacts
//
//  Created by GLB-311-PC on 12/01/19.
//  Copyright © 2019 Globussoft. All rights reserved.
//

import UIKit

class contactsTableViewCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
