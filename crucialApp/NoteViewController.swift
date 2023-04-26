//
//  NoteViewController.swift
//  crucialApp
//
//  Created by Mohan K on 17/03/23.
//

import UIKit

class NoteViewController: UIViewController {
    private var noteId: String!
    private var index: Int!
    
    @IBOutlet weak var titileTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!

    var noteCell: NoteCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        index = ViewController.notes.firstIndex(where: {$0.id == noteId})!
        view.backgroundColor = .systemBackground
        self.navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let note = ViewController.notes[index]
        titileTextField.text = note.title
        contentTextView.text = note.text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let noteCell = noteCell else {
            return
        }
        noteCell.prepareNote()
        noteCell.configure(note: ViewController.notes[index])
        noteCell.configureLabels()
    }
    
    private func setupNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
    }
    @IBAction func titletxtField(_ sender: Any) {
    }
    func set(noteId: String) {
        self.noteId = noteId
    }
    
    func set(noteCell: NoteCell) {
        self.noteCell = noteCell
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

extension NoteViewController: UITextFieldDelegate, UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        ViewController.notes[index].text = contentTextView.text
        CoreDataManager.shared.save()

    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        ViewController.notes[index].title = titileTextField.text!
        CoreDataManager.shared.save()
    }
}

extension NoteViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
