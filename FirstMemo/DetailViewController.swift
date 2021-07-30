//
//  DetailViewController.swift
//  FirstMemo
//
//  Created by Martin.Q on 2021/07/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var memoTableView: UITableView!
    var data: Memo?
    
    @IBAction func deleteMemo(_ sender: Any) {
        let alert = UIAlertController(title: "Delete", message: "Delete this memo", preferredStyle: .alert)
        let allowBtn = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (action) in
            DataManager.shared.deleteMemo(self?.data)
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(allowBtn)
        alert.addAction(cancelBtn)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func share(_ sender: Any) {
        
        guard let memo = data?.content else {
            return
        }
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        present(vc, animated: true, completion: nil)
    }
    
    let formatter: DateFormatter = {
        let formatted = DateFormatter()
        formatted.dateStyle = .long
        formatted.timeStyle = .short
        formatted.locale = Locale(identifier: "Ko_kr")
        return formatted
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController {
            vc.editTarget = data
        }
    }
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        token = NotificationCenter.default.addObserver(forName: ComposeViewController.memoUpdated, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            self?.memoTableView.reloadData()
        })
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
            
            cell.textLabel?.text = formatter.string(for: data?.insertDate)
            if #available(iOS 11, *) {
                cell.textLabel?.textColor = UIColor(named: "myLabelColor")
            } else {
                cell.textLabel?.textColor = UIColor.lightGray
            }
            
            return cell
        default:
            fatalError()
        }
    }
}
