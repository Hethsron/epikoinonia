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
    @file               BookViewController.swift
    @details         Book  controller view of the application used to manage  Booking Tab
    
    @author         Hethsron Jedaël BOUEYA (hethsron-jedael.boueya@uha.fr)
    @author         Pranamika SOLANKI  (pranamika.solanki@uha.fr)
 
    @version        0.0.1
    @date            November 10th, 2020
 
    @copyright     GPL3+ : GNU GPL version 3 or later, Licencied Material - Property of Hethsron
*/
import UIKit
import CoreData

class BookViewController: UIViewController {
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func onClear() {
        self.firstnameTextField.text = ""
        self.lastnameTextField.text = ""
        self.addressTextField.text = ""
        self.phoneNumberTextField.text = ""
        self.emailTextField.text = ""
    }

    @IBAction func onFirstName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onLastName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onAddress(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onEmail(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onBackgroundTap(_ sender: UIControl) {
        firstnameTextField.resignFirstResponder()
        lastnameTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    @IBAction func onSave(_ sender: Any) {
        guard let firstname = firstnameTextField.text else { return }
        guard let lastname = lastnameTextField.text else { return }
        guard let address = addressTextField.text else { return }
        guard let phone = phoneNumberTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        if (firstname.count < 1) {
            return
        }
        
        if (lastname.count < 1) {
            return
        }
        
        if (address.count < 1) {
            return
        }
        
        if (phone.count < 1) {
            return
        }
        
        if (email.count < 1) {
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Contacts", in: context) else { return }
        let contact = NSManagedObject(entity: entity, insertInto: context) as! Contacts
        
        contact.setValue(lastname, forKey: "lastname")
        contact.setValue(firstname, forKey: "firstname")
        contact.setValue(address, forKey: "address")
        contact.setValue(phone, forKey: "phone")
        contact.setValue(email, forKey: "email")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
        
        self.onClear()
    }
    
    @IBAction func onReturn(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onDelete(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Supprimer le contact", message: "Vous êtes sur le point de supprimer le contact", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Supprimer definitivement le contact", style: .destructive, handler: { action in
            let alert = UIAlertController(title: "Confirmation", message: "Suppression en cours de traitement", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                self.onClear()
            }))
            self.present(alert, animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
}
