//
//  ViewController.swift
//  Clinic Task
//
//  Created by Ahmed Zaki on 3/18/19.
//  Copyright © 2019 Ahmed Zaki. All rights reserved.
//

import UIKit

class DoctorsViewController: UIViewController
{

    @IBOutlet var doctorsTabelView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupDoctorsTableview()
        doctorsTabelView.delegate = self
        doctorsTabelView.dataSource = self
       
    }
    private func setupDoctorsTableview()
    {
        registerDoctorTableCells()
        doctorsTabelView.estimatedRowHeight = 150
        doctorsTabelView.rowHeight = UITableView.automaticDimension
    }

    
    private func registerDoctorTableCells()
    {
        let doctorCellNib = UINib(nibName: DoctorCell.identifier, bundle: nil)
        doctorsTabelView.register(doctorCellNib, forCellReuseIdentifier: DoctorCell.identifier)
    }

}

extension DoctorsViewController : UITableViewDataSource ,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
         let cell = doctorsTabelView.dequeueReusableCell(withIdentifier: DoctorCell.identifier) as! DoctorCell
            cell.doctorNameLabel.text = "Ahmed youssef Zaki"
            return cell
       
    }
}
