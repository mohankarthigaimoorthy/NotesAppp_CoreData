//
//  Extensions.swift
//  crucialApp
//
//  Created by Mohan K on 17/03/23.
//

import Foundation
import UIKit

extension UILabel {
    func animateIn() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
        self.alpha = 1.0
        }, completion: nil)
    }
    
    func animateOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
}

extension Date {
    static func isToday(day: Int) -> Bool {
        return Calendar.current.dateComponents([.day], from: .now).day == day
    }
    
    static func isThisYear(year: Int) -> Bool {
        return Calendar.current.dateComponents([.year], from: .now).year == year
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
    extension Date {
        func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(component, from: self)
        }
    }

    
//    extension UITextView {
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//            self.translatesAutoresizingMaskIntoConstraints = false
//            let font = UIFont.boldSystemFont(ofSize: 28)
//            self.font = font
//            self.autocorrectionType = .no
//            let attributes: [NSAttributedString.Key: Any] = [
//                .font: font,
//                .foregroundColor: UIColor.gray
//            ]
//            self.attributedPlaceholder = NSAttributedString(string: "Title", attributes: attributes)
//        }
//        
//        required init?(coder: NSCoder) {
//            super.init(coder: coder)
//        }
//    }
//
//    extension UITextField {
//        
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//            self.translatesAutoresizingMaskIntoConstraints = false
//            let font = UIFont.boldSystemFont(ofSize: 28)
//            self.font = font
//            self.autocorrectionType = .no
//            let attributes: [NSAttributedString.Key: Any] = [
//                .font: font,
//                .foregroundColor: UIColor.gray
//            ]
//            self.attributedPlaceholder = NSAttributedString(string: "Title", attributes: attributes)
//        }
//        
//        required init?(coder: NSCoder) {
//            super.init(coder: coder)
//        }
//    }
//
//
//    extension UIButton {
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//    //            self.setImage(UIImage(systemName: "rectangle.stack.badge.plus"), for: .normal)
//            self.contentVerticalAlignment = .fill
//            self.contentHorizontalAlignment = .fill
//        }
//        
//        required init?(coder: NSCoder) {
//            super.init(coder: coder)
//        }
//        
//    //        func setButtonConstraints(view: UIView) {
//    //            self.translatesAutoresizingMaskIntoConstraints = false
//    //            self.widthAnchor.constraint(equalToConstant: 40).isActive = true
//    //            self.heightAnchor.constraint(equalToConstant: 40).isActive = true
//    //            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
//    //            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45).isActive = true
//    //        }
//
//    }


