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
    @file               ViewController.swift
    @details         LaunchScreen  controller view of the application used to manage  splash animation
    
    @author         Hethsron Jedaël BOUEYA (hethsron-jedael.boueya@uha.fr)
    @author         Pranamika SOLANKI  (pranamika.solanki@uha.fr)
 
    @version        0.0.1
    @date            November 10th, 2020
 
    @copyright     GPL3+ : GNU GPL version 3 or later, Licencied Material - Property of Hethsron
*/
import UIKit

class ViewController: UIViewController {
    
    private let imageView : UIImageView = {
        let _x = 0
        let _y = 0
        let _width = 256
        let _height = 256
        
        let imageView = UIImageView(frame : CGRect(x: _x, y: _y, width: _width, height: _height))
        imageView.image = UIImage(named: "epikoinonia")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.animate()
        })
    }
    
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 3
            let _x = size - self.view.frame.size.width
            let _y = self.view.frame.size.height - size
            
            self.imageView.frame = CGRect(
                x: -(_x / 2),
                y: (_y / 2),
                width: size,
                height: size)
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if (done) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    let mainController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                    mainController.modalTransitionStyle = .crossDissolve
                    mainController.modalPresentationStyle = .fullScreen
                    mainController.selectedViewController = mainController.viewControllers?[0]
                    self.present(mainController, animated: true, completion: nil)
                })
            }
        })
    }
}

