//
//  UserUtils.swift
//  StackEm
//
//  Created by Daniel Dao on 11/9/15.
//  Copyright © 2015 Don Negro. All rights reserved.
//

import Foundation
import Parse

func getCurrentUserId() -> String?{
    return (PFUser.currentUser()?.objectId)!
}

func getCurrentUserName() -> String?{
    return PFUser.currentUser()?.username
}