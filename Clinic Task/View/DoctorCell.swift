//
//  DoctorCell.swift
//  Clinic Task
//
//  Created by Ahmed Zaki on 3/18/19.
//  Copyright © 2019 Ahmed Zaki. All rights reserved.
//

import UIKit

class DoctorCell: UITableViewCell
{

    
    @IBOutlet weak var doctorFeeLabel: UILabel!
    @IBOutlet weak var doctorNumofFollowersLabel: UILabel!
    @IBOutlet weak var doctorSpcialistLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var bookedButton: UIButton!
    static let identifier = "DoctorCell"
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
