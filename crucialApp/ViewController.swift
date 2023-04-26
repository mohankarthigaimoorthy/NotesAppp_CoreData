//
//  ViewController.swift
//  crucialApp
//
//  Created by Mohan K on 17/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var searchBarIsEmpty: Bool {
        guard let text  = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    private var isSearching: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var teableView: UITableView!
    @IBOutlet weak var createBtn: UIButton!
  
    var searchedNotes = [Note]()
    static var notes =  [Note]()
    var searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        
//        label.translatesAutoresizingMaskIntoConstraints = false
        fetchNotesFromStorage()
        setupTableView()
    }

    func setupTableView() {
        teableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.id)
        teableView.delegate = self
        teableView.dataSource = self
        teableView.separatorColor = .systemGray3
//        self.teableView = self.teableView
        teableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            teableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

    }
    @IBAction func createButton(_ sender: Any) {
      
        let newNote = CoreDataManager.shared.createNote()
        ViewController.notes.insert(newNote, at: 0)
        
        teableView!.beginUpdates()
        teableView!.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        teableView!.endUpdates()
        
        guard  let noteVC = storyboard?.instantiateViewController(identifier: "NoteViewController")
                as? NoteViewController else {return}
        noteVC.noteCell = nil
        noteVC.set(noteId: newNote.id)
        noteVC.set(noteCell: (teableView?.cellForRow(at: IndexPath(row: 0, section: 0)) as! NoteCell))
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            label.isHidden = true
            return searchedNotes.count
        }
        
        else{
            label.isHidden = false
            ViewController.notes.count == 0 ?
            label.animateIn() :
            label.animateOut()
            return ViewController.notes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = teableView.dequeueReusableCell(withIdentifier: NoteCell.id, for: indexPath) as? NoteCell else { return UITableViewCell()}
    if isSearching {
        cell.configure(note: searchedNotes[indexPath.row])
    }else {
        cell.configure(note: ViewController.notes[indexPath.row])
    }
    cell.configureLabels()
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        guard  let noteVC = storyboard?.instantiateViewController(identifier: "NoteViewController")
                as? NoteViewController else {return}
        if isSearching {
            noteVC.set(noteId: searchedNotes[indexPath.row].id)
            
        }else {
            noteVC.set(noteId: ViewController.notes[indexPath.row].id)
        }
        guard let cell = tableView.cellForRow(at: indexPath) as? NoteCell else{return}
        noteVC.set(noteCell: cell)
    navigationController?.pushViewController(noteVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        removeNote(row: indexPath.row, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if isSearching{
            return false
        }
        return true
    }
    
    internal func removeNote(row: Int, tableView: UITableView ) {
        deleteNotesFromStorage(at: row)
        ViewController.notes.remove(at: row)
        let path = IndexPath(row: row, section: 0)
        tableView.deleteRows(at: [path], with: .top)
    }
    
    internal func removeCellIfEmpty() {
        guard let firstNoteCell = ViewController.notes.first else {
            return
        }
        if firstNoteCell.title.trimmingCharacters(in: .whitespaces).isEmpty
            &&
            firstNoteCell.text.trimmingCharacters(in: .whitespaces).isEmpty
        {
            removeNote(row: 0,tableView: teableView! )
        }
    }
}

extension ViewController {
    func fetchNotesFromStorage() {
        ViewController.notes = CoreDataManager.shared.fetchNotes()
        
    }
    
    private func deleteNotesFromStorage(at index: Int) {
        CoreDataManager.shared.deleteNote(ViewController.notes[index])
    }
    
    func searchNotesFromStorage(_ text: String) {
        searchedNotes = CoreDataManager.shared.fetchNotes(filter: text)
        teableView?.reloadData()
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        search(text: text)
    }
    
    func search(text: String) {
        searchNotesFromStorage(text)
    }
}
