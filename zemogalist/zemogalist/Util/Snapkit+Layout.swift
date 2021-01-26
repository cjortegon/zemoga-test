//
//  Snapkit+Layout.swift
//  ios-saas
//
//  Created by Camilo Ortegon on 9/24/19.
//  Copyright © 2019 Camilo Ortegon. All rights reserved.
//

import UIKit
import SnapKit

precedencegroup AnchorPrecedence {
    associativity: right
    lowerThan: AdditionPrecedence, MultiplicationPrecedence
}

infix operator |=| : AnchorPrecedence

@discardableResult public func |=|<T: ConstraintMakerExtendable, U: ConstraintItem>(left: T, right: U) -> ConstraintMakerEditable {
    return left.equalTo(right)
}
@discardableResult public func |=|<T: ConstraintMakerExtendable, U: ConstraintItemContainer>(left: T, right: U) -> ConstraintMakerEditable {
    switch right.type {
    case .multiply:
        return left.equalTo(right.item).multipliedBy(right.offset)
    case .offset:
        return left.equalTo(right.item).offset(right.offset)
    }
}
@discardableResult public func |=|<T: ConstraintMakerExtendable, CGFloat>(constraint: T, value: CGFloat) -> ConstraintMakerEditable {
    return constraint.equalTo(value as! ConstraintRelatableTarget)
}
@discardableResult public func +<T: ConstraintItemContainer>(constraint: T, value: CGFloat) -> ConstraintItemContainer {
    constraint.offset = value
    return constraint
}
@discardableResult public func -<T: ConstraintItemContainer>(constraint: T, value: CGFloat) -> ConstraintItemContainer {
    constraint.offset = -value
    return constraint
}
@discardableResult public func *<T: ConstraintItemContainer>(constraint: T, value: CGFloat) -> ConstraintItemContainer {
    constraint.offset = value
    constraint.type = .multiply
    return constraint
}

enum ConstraintItemContainerType {
    case multiply
    case offset
}

public class ConstraintItemContainer {
    var item : ConstraintItem
    var offset : CGFloat
    var type : ConstraintItemContainerType = .offset
    
    init(_ item: ConstraintItem) {
        self.item = item
        self.offset = 0
    }
    init(_ item: ConstraintItem, offset: CGFloat, type: ConstraintItemContainerType) {
        self.item = item
        self.offset = offset
        self.type = type
    }
}

public extension UILayoutSupport {
    var s_top: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.top)
        }
    }
    var s_bottom: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.bottom)
        }
    }
}

public extension ConstraintView {
    var s_top: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.top)
        }
    }
    var s_bottom: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.bottom)
        }
    }
    var s_left: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.left)
        }
    }
    var s_right: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.right)
        }
    }
    var s_width: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.width)
        }
    }
    var s_height: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.height)
        }
    }
    var s_center: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.center)
        }
    }
    var s_centerX: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.centerX)
        }
    }
    var s_centerY: ConstraintItemContainer {
        get {
            return ConstraintItemContainer(self.snp.centerY)
        }
    }
}
