//
//  DetailViewController.swift
//  FirstMemo
//
//  Created by Martin.Q on 2021/07/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    var data: Memo?
    
    let formatter: DateFormatter = {
        let formatted = DateFormatter()
        formatted.dateStyle = .long
        formatted.timeStyle = .short
        formatted.locale = Locale(identifier: "Ko_kr")
        return formatted
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            
            cell.textLabel?.text = data?.content
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            
            cell.textLabel?.text = formatter.string(for: data?.date)
            
            return cell
        default:
            fatalError()
        }
    }
}