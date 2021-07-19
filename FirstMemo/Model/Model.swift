//
//  Model.swift
//  FirstMemo
//
//  Created by Martin.Q on 2021/07/19.
//

import Foundation

class Memo {
    var content: String
    var date: Date
    
    init(content: String) {
        self.content = content
        date = Date()
    }
    
    static var dummyMemoList = [
        Memo(content: "What I said to you remains like a will.")
    ]
}
