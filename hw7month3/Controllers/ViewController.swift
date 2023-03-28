//
//  ViewController.swift
//  hw7month3
//
//  Created by Nurjamal Mirbaizaeva on 26/3/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var persons: [Person] = []
    private var filteredPersons: [Person] = []
    private var isFiltering = false
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let nameLabel = UILabel()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       initUI()
       initDate()
    }
    
    private func initUI(){
        navigationItem.titleView = searchBar
        view.backgroundColor = .white
        searchBar.placeholder = "JI. Merah Biru Nomor 123"
        
        nameLabel.text = "Or select via map?"
        nameLabel.textColor = .blue
        nameLabel.textAlignment = .center
        
        button.setTitle("Done", for: .normal)
        button.layer.cornerRadius = 22
        button.backgroundColor = .tintColor

        tableView.dataSource = self
        searchBar.delegate = self
                
        view.addSubview(tableView)
        view.addSubview(nameLabel)
        view.addSubview(button)
        
        tableView.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(180)
        }
        nameLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(130)
        }
        button.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(nameLabel.snp.bottom).offset(530)
            make.height.equalTo(50)
        }
    }
    private func initDate(){
        persons = [Person(company: "ABC Company", person: "JI. Merah Biru Nomor 123"), Person(company: "PQR Company", person: "JI. Merah Biru Nomor 456"), Person(company: "XYZ Company", person: "JI. Merah Biru Nomor 789"), Person(company: "ABCD Company", person: "JI. Merah Biru Nomor 123"), Person(company: "PQRS Company", person: "JI. Merah Biru Nomor 789"), Person(company: "WXYZ Company", person: "JI. Merah Biru Nomor 455")]
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredPersons.count : persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = isFiltering ? filteredPersons[indexPath.row].company : persons[indexPath.row].company
        cell.detailTextLabel?.text = isFiltering ? filteredPersons[indexPath.row].person : persons[indexPath.row].person
        
        return cell
    }
}
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            
        }else{
            isFiltering = true
            filteredPersons = persons.filter({ $0.company.lowercased().contains(searchText.lowercased())})
        }
        tableView.reloadData()
    }
}
