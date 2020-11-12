//  Copyright © 2020  Hethsron Jedaël BOUEYA

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

/**
    @file               NameViewController.swift
    @details         Name  controller view of the application used to manage  Name Tab
    
    @author         Hethsron Jedaël BOUEYA (hethsron-jedael.boueya@uha.fr)
    @author         Pranamika SOLANKI  (pranamika.solanki@uha.fr)
 
    @version        0.0.1
    @date            November 10th, 2020
 
    @copyright     GPL3+ : GNU GPL version 3 or later, Licencied Material - Property of Hethsron
*/
import UIKit
import CoreData

class NameViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var contacts = [Contacts]()
    var names = [String]()
    var sectionTitle = [String]()
    var nameDict = [String: [String]]()
    
    private func onLoad(_ contacts: [Contacts]) {
        contacts.forEach({ contact in
            names.append(String(contact.firstname!) + " " + String(contact.lastname!))
        })
    }
    
    private func doInBackground() {
        self.onFetch()
        tableView.reloadData()
        self.onLoad(contacts)
    }
    
    private func onResume(_ name: String) -> String {
        var result : String = String()
        if (!contacts.isEmpty) {
            contacts.forEach ({ contact in
                if ((String(contact.firstname!) + " " + String(contact.lastname!)) == name) {
                    result = String(contact.phone!)
                }
            })
        }
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.doInBackground()
        
        sectionTitle = Array(Set(names.compactMap({ String($0.prefix(1)) })))
        sectionTitle.sort()
        sectionTitle.forEach({ nameDict[$0] = [String]() })
        names.forEach({ nameDict[String($0.prefix(1))]?.append($0) })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.doInBackground()
    }
    
    private func onFetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        
        do {
            contacts = try context.fetch(request) as! [Contacts]
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
}

extension NameViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameDict[sectionTitle[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = nameDict[sectionTitle[indexPath.section]]?[indexPath.row]
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
        label.text = onResume(String((cell.textLabel?.text)!))
        cell.accessoryView = label
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitle[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitle
    }
}
