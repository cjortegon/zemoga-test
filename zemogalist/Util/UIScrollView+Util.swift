//
//  UIScrollView+Util.swift
//  zemogalist
//
//  Created by Camilo Ortegon on 25/01/21.
//

import UIKit

extension UIScrollView {

    func wrapContent() {
        self.contentSize = getContentSize()
    }

    func getContentSize() -> CGSize {
        let contentRect: CGRect = self.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        return contentRect.size
    }

}
