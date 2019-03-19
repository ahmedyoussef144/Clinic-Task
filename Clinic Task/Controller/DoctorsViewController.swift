//
//  ViewController.swift
//  Clinic Task
//
//  Created by Ahmed Zaki on 3/18/19.
//  Copyright © 2019 Ahmed Zaki. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll
typealias completionType = ((Decodable)->())
typealias errorType = ((Error?)->())

class DoctorsViewController: UIViewController {
    
    @IBOutlet var doctorsTabelView: UITableView!
    
    private var offset = 0
    private var limit = 5
    private var doctors : [Doctor] = []
    private var networkManger = NetworkManger.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupDoctorsTableview()
        loadDoctors()
        setupTabelViewInfinitScrol()
    }
    //MARK: - TabelView SetUp Methods
    private func setupDoctorsTableview() {
        doctorsTabelView.delegate = self
        doctorsTabelView.dataSource = self
        registerDoctorTableCells()
        doctorsTabelView.estimatedRowHeight = 150
        doctorsTabelView.rowHeight = UITableView.automaticDimension
    }
    
    private func registerDoctorTableCells() {
        let doctorCellNib = UINib(nibName: DoctorCell.identifier, bundle: nil)
        doctorsTabelView.register(doctorCellNib, forCellReuseIdentifier: DoctorCell.identifier)
    }
    
    func setupTabelViewInfinitScrol() {
        doctorsTabelView.addInfiniteScroll {
            (tabelView) in
            self.loadDoctors()
            tabelView.finishInfiniteScroll()
        }
    }
    //MARK: - Fetching Data Methods
    func loadDoctors() {
        networkManger.getDoctors(body: DoctorsEndPoint.init(offset: offset, limit: limit), andCompletion: {
            (result) in
            if let result = result as? DoctorsResponse {
                if result.error?.status == true , let doctors = result.response {
                    self.handelLoadingDoctors(doctors : doctors)
                }
                else {
                    //Show Loading data Error Message
                    self.handelErorLoadingDoctors()
                }
            }
            else {
                //Show Loading data Error Message
                self.handelErorLoadingDoctors()
            }
        })
        {
            (error) in
            //Show network Error Message
            self.showAlert(withMessage: "\(error)", andTitle: "Netwrok Error")
        }
    }
    
    func handelLoadingDoctors(doctors : [Doctor]) {
        self.doctors.append(contentsOf: doctors)
        offset += 5
        doctorsTabelView.reloadData()
    }
    
    func handelErorLoadingDoctors() {
        // Show alert
        showAlert(withMessage: "Error In Fetching Data", andTitle: "Loading Error")
    }
}

//MARK: - TableView Datasource and Delegate Methods
extension DoctorsViewController : UITableViewDataSource ,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = doctorsTabelView.dequeueReusableCell(withIdentifier: DoctorCell.identifier) as! DoctorCell
        cell.configure(doctor: doctors[indexPath.row])
        return cell
        
    }
}

//MARK: - Alert SetUp Method
extension DoctorsViewController
{
    func showAlert(withMessage message: String , andTitle title: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert , animated: true)
    }
}
