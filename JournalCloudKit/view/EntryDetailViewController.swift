//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Pete Parks on 5/11/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    var entry: Entry? {
        didSet {
            self.loadViewIfNeeded()
            self.updatesViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titletextFieldLabel.delegate = self
    }
    
    @IBOutlet weak var titletextFieldLabel: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
@IBAction func mainViewTapped(_ sender: Any) {
    titletextFieldLabel.resignFirstResponder()
    bodyTextView.resignFirstResponder()
}
    


    
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titletextFieldLabel.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titletextFieldLabel.text, let textBody = bodyTextView.text, !title.isEmpty, !textBody.isEmpty else { return }
        
        EntryController.shared.createEntry(with: title, entryText: textBody) { (results) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
}

extension EntryDetailViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titletextFieldLabel.resignFirstResponder()
    }
    
    func updatesViews() {
        guard let entry = self.entry else { return }
        titletextFieldLabel.text = entry.title
        bodyTextView.text = entry.entryText
    }
}
