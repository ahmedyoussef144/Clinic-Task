//
//  ViewController.swift
//  Clinic Task
//
//  Created by Ahmed Zaki on 3/18/19.
//  Copyright © 2019 Ahmed Zaki. All rights reserved.
//

import UIKit

typealias completionType = ((Decodable)->())
typealias errorType = ((Error?)->())
class DoctorsViewController: UIViewController
{
    
    @IBOutlet var doctorsTabelView: UITableView!
    private var doctors : [Doctor] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupDoctorsTableview()
        doctorsTabelView.delegate = self
        doctorsTabelView.dataSource = self
        getDoctors(andCompletion:
            {
                (result) in
                if let result = result as? DoctorsResponse
                {
                    if result.error?.status == true , let doctors = result.response
                    {
                        self.handelLoadingDoctors(doctors : doctors)
                        
                    }
                    else
                    {
                        self.handelErorLoadingDoctors()
                    }
                    
                }
                else
                {
                    self.handelErorLoadingDoctors()
                }
                
        })
        { (error) in
            //Show network Error Message
            print(error)
        }
        
    }
    func handelLoadingDoctors(doctors : [Doctor])
    {
        self.doctors = doctors
        doctorsTabelView.reloadData()
    }
    func handelErorLoadingDoctors() {
        // Show alert
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
    private func getDoctors(andCompletion completion: @escaping completionType , andErrorHandler errorHandler: @escaping errorType)
    {
        let url = URL(string: "https://admin-seena.com/api/doctors/all")
        var request = URLRequest(url: url! )
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            if  error != nil
            {
                DispatchQueue.main.async
                    {
                        errorHandler(error)
                }
            }
            else
            {
                if let data = data
                {
                    do
                    {
                        let decoder = JSONDecoder()
                        let result  = try decoder.decode(DoctorsResponse.self, from: data)
                        DispatchQueue.main.async
                            {
                                completion(result)
                        }
                    }
                    catch
                    {
                        DispatchQueue.main.async
                            {
                                print(error)
                                errorHandler(error)
                        }
                    }
                }
                else
                {
                    DispatchQueue.main.async
                        {
                            errorHandler(error)
                    }
                }
            }
        }
        task.resume()
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
