//
//  NoteCell.swift
//  crucialApp
//
//  Created by Mohan K on 17/03/23.
//

import UIKit

class NoteCell: UITableViewCell {

    static let  id = "NoteCell"
    private var note: Note?
   
    var dateLabel: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .systemBackground
        textLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        detailTextLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        setupDateLabel()
        // Initialization code
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func   setupDateLabel() {
        dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 74, height: 50))
        dateLabel.textAlignment = .right
        accessoryView = dateLabel

        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 14)
    }
    
    func configureLabels() {
        self.textLabel?.text = note?.title ?? ""
        self.detailTextLabel?.text = note?.text ?? ""
        
        guard note != nil else {
            print("Found nil value in variable note")
            return
            let formatter = DateFormatter()
            if Date.isToday(day: note!.date.get(.day)) {
                formatter.dateFormat = "HH:mm"
            } else if Date.isThisYear(year: note!.date.get(.year)) {
                formatter.dateFormat = "MMM d"
            } else {
                formatter.dateFormat = "MM/dd/yyyy"
            }
            dateLabel.text = formatter.string(from: note!.date)
        }
        
        
    }
    
    func configure(note: Note)
    {
        self.note = note
    }
    func prepareNote() {
        self.note = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
