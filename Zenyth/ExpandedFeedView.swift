//
//  ExpandedFeedView.swift
//  Zenyth
//
//  Created by Hoang on 8/30/17.
//  Copyright © 2017 Hoang. All rights reserved.
//

import Foundation
import UIKit

class ExpandedFeedView: UIScrollView {
    
    var imagesScroller: ImagesScroller!
    var commentsView: CommentsView!
    var pinpost: Pinpost!
    var feedInfoView: FeedInfoView!
    var profilePicView: UIImageView!
    var returnButton: UIButton!
    
    var maxHeight: CGFloat = 0
    var controller: UIViewController?
    
    // Constants for UI sizing
    static let CELL_HEIGHT: CGFloat = 0.08
    static let FEED_INFO_HEIGHT: CGFloat = 0.40
    static let WIDTH_OF_PROFILE_PIC: CGFloat = 0.18
    static let PIC_LEFT_INSET: CGFloat = 0.03
    static let BUTTON_TOP_INSET: CGFloat = 0.03
    
    static let WIDTH_OF_RETURN_BUTTON: CGFloat = 0.11
    
    init(controller: UIViewController, frame: CGRect, pinpost: Pinpost) {
        self.controller = controller
        super.init(frame: frame)
        self.pinpost = pinpost
        
        setupImagesScroller()
        setupFeedInfoView(pinpost: pinpost)
        
        if let comments = pinpost.comments {
            setupCommentsView(comments: comments)
        }
        
        setupProfilePicView(user: pinpost.creator!)
        setupReturnButton()
        
        maxHeight += imagesScroller.frame.height
        maxHeight += feedInfoView.frame.height
        maxHeight += commentsView.frame.height
        
        self.contentSize.height = maxHeight
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .white
        
        returnButton.addTarget(controller,
                               action: #selector(ExpandedFeedController.popBack),
                               for: .touchUpInside)
    }
    
    func setupImagesScroller() {
        let width = self.frame.width
        let height = width
        let x = CGFloat(0)
        let y = CGFloat(0)
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        imagesScroller = ImagesScroller(frame: frame)
        self.addSubview(imagesScroller)
    }
    
    func setupProfilePicView(user: User) {
        let width = self.frame.width * ExpandedFeedView.WIDTH_OF_PROFILE_PIC
        let height = width
        let x = self.frame.width * ExpandedFeedView.PIC_LEFT_INSET
        let y = feedInfoView.frame.origin.y - height/2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        profilePicView = UIImageView(frame: frame)
        if let image = user.profilePicture {
            profilePicView.imageFromUrl(withUrl: image.url)
        }
        else {
            profilePicView.image = #imageLiteral(resourceName: "default_profile")
        }
        let container = profilePicView.roundedImageWithShadow(frame: frame)
        self.addSubview(container)
    }
    
    func setupFeedInfoView(pinpost: Pinpost) {
        let width = self.frame.width
        let height = self.frame.height * ExpandedFeedView.FEED_INFO_HEIGHT
        let x = CGFloat(0)
        let y = imagesScroller.frame.maxY
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        feedInfoView = FeedInfoView(controller!, frame: frame, pinpost: pinpost)
        
        feedInfoView!.frame = CGRect(x: feedInfoView!.frame.origin.x,
                                     y: feedInfoView!.frame.origin.y,
                                     width: feedInfoView!.frame.width,
                                     height: feedInfoView!.maxHeight)
        
        self.addSubview(feedInfoView)
    }
    
    func setupCommentsView(comments: [Comment]) {
        let width = self.frame.width
        let height = self.frame.height * ExpandedFeedView.CELL_HEIGHT
        let x = CGFloat(0)
        let y = feedInfoView.frame.maxY
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        commentsView = CommentsView(commentFrame: frame, comments: comments)
        
        self.addSubview(commentsView)
    }
    
    func setupReturnButton() {
        let width = self.frame.width * ExpandedFeedView.WIDTH_OF_RETURN_BUTTON
        let height = width
        let x = self.center.x - width/2
        let y = self.frame.height * ExpandedFeedView.BUTTON_TOP_INSET
        
        let frame = CGRect(x: x, y: y, width: width, height: height)

        returnButton = UIButton(frame: frame)
        returnButton.setImage(#imageLiteral(resourceName: "down_icon"), for: .normal)
        
        self.addSubview(returnButton)
    }
    
    func addComment(comment: Comment) {
        commentsView.append(comment: comment)
        self.contentSize.height += self.frame.height * ExpandedFeedView.CELL_HEIGHT
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
