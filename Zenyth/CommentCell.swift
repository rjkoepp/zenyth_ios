//
//  CommentCell.swift
//  Zenyth
//
//  Created by Hoang on 8/30/17.
//  Copyright © 2017 Hoang. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UIView {
    
    var profilePicView: UIImageView!
    var usernameLabel: UILabel!
    var commentField: UITextView!
    var comment: Comment!
    
    // Constants for ui sizing
    static let LEFT_INSET: CGFloat = 0.03
    static let TOP_INSET: CGFloat = 0.05
    
    static let PROFILE_PIC_HEIGHT: CGFloat = 0.90
    static let USERNAME_HEIGHT: CGFloat = 0.29
    static let USERNAME_WIDTH: CGFloat = 0.30
    static let COMMENT_HEIGHT: CGFloat = 0.65
    static let COMMENT_WIDTH: CGFloat = 0.80
    
    static let GAP_B_PIC_A_COMMENT: CGFloat = 0.05
    static let GAP_B_USERNAME_A_COMMENT: CGFloat = 0.05
    static let TOP_BORDER_THICKNESS: CGFloat = 1.0
    
    init(frame: CGRect, comment: Comment) {
        self.comment = comment
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupProfilePicView()
        setupUsernameLabel(username: comment.creator.username)
        setupCommentField(text: comment.text)
        
        self.topBorder(color: UIColor.black.cgColor,
                       width: CommentCell.TOP_BORDER_THICKNESS)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupProfilePicView() {
        let height = self.frame.height * CommentCell.PROFILE_PIC_HEIGHT
        let width = height
        let x = self.frame.width * CommentCell.LEFT_INSET
        let y = self.frame.height * CommentCell.TOP_INSET
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        profilePicView = UIImageView(frame: frame)
        profilePicView.image = #imageLiteral(resourceName: "default_profile")
        let container = profilePicView.roundedImageWithShadow(frame: frame)
        self.addSubview(container)
    }
    
    func setupUsernameLabel(username: String) {
        let height = self.frame.height * CommentCell.USERNAME_HEIGHT
        let width = self.frame.width * CommentCell.USERNAME_WIDTH
        let gap = self.frame.width * CommentCell.GAP_B_PIC_A_COMMENT
        let x = profilePicView.frame.maxX + gap
        let y = self.frame.height * CommentCell.TOP_INSET
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        usernameLabel = UILabel(frame: frame)
        usernameLabel.text = username
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        self.addSubview(usernameLabel)
    }
    
    func setupCommentField(text: String) {
        let height = self.frame.height * CommentCell.COMMENT_HEIGHT
        let width = self.frame.width * CommentCell.COMMENT_WIDTH
        let x = usernameLabel.frame.origin.x
        let gap = self.frame.height * CommentCell.GAP_B_USERNAME_A_COMMENT
        let y = usernameLabel.frame.maxY + gap
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        commentField = UITextView(frame: frame)
        commentField.text = text
        commentField.font = UIFont.systemFont(ofSize: 12.0)
        commentField.isEditable = false
        commentField.textContainerInset = UIEdgeInsets.zero
        commentField.textContainer.lineFragmentPadding = 0
        
        self.addSubview(commentField)
    }
    
    func renderProfilePic() {
        if let image = comment.creator.profilePicture {
            self.profilePicView.imageFromUrl(withUrl: image.getURL(size: "small"))
        }
    }
    
    func setProfilePic(image: UIImage) {
        self.profilePicView.image = image
    }
}