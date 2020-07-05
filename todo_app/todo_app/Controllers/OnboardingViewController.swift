//
//  OnboardingViewController.swift
//  todo_app
//
//  Created by Vinicius on 03/07/20.
//  Copyright © 2020 Vinicius. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        guard let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            else{
                return
        }
                defaults.set(true, forKey: "tutorialFinished")
        navigationController?.pushViewController(homeViewController, animated: true)
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
