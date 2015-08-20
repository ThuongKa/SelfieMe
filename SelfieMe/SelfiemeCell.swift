//
//  SelfiemeCell.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/30/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class SelfiemeCell: UITableViewCell {
    
    /// Delegate
    var delegate: SelfiemeCellDelegate?
    
    /// The button is selected
    var isSelect = false {
        didSet {
            if self.isSelect {
                self.tickButton.setBackgroundImage(UIImage(named: "tick"), forState: .Normal)
            } else {
                self.tickButton.setBackgroundImage(UIImage(named: "add"), forState: .Normal)
            }
        }
    }
    
    /// User profile picture
    @IBOutlet weak var avatarImageView: UIImageView!
    
    /// User name
    @IBOutlet weak var usernameLabel: UILabel!
    
    /// Tick button
    @IBOutlet weak var tickButton: UIButton!
    
    
    override func awakeFromNib() {

    }
    
    /**
    
    */
    func bindingDataToCell(friend: Friend) {
        usernameLabel.text = friend.username
        avatarImageView.image = friend.userImage
    }

    /**
        Click on tick button
    */
    @IBAction func onClickTickButton(sender: AnyObject) {
        if self.isSelect {
            self.isSelect = false
        } else {
            self.isSelect = true
        }
        delegate?.didTouchOnTickButton(self, select: self.isSelect)
    }
}

protocol SelfiemeCellDelegate {
    func didTouchOnTickButton(cell: SelfiemeCell, select: Bool)
}