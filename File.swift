		//
//  File.swift
//  Mobile App Dev. Project
//
//  Created by Deli-MAC on 3/5/15.
//  Copyright (c) 2015 Deli-MAC. All rights reserved.
//

import Foundation
        
        
        let cardValues:Dictionary<Int,String> = [1:"A",2:"2",3:"3",4:"4",5:"5",6:"6",7:"7",8:"8",9:"9",10:"10",11:"J",12:"Q",13:"K"]
        let scoreValues:Dictionary<String,Int> = ["A":1,"2":2,"3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9,"10":10,"J":10,"Q":10,"K":10]

        
class card{
    init(theSuit:String, theValue:Int) {
        suit = theSuit
        value = (cardValues[theValue])!
    }
    var suit:String
    var value:String
}
        
struct player{
    init(playerID:Int) {	
        money = 100
        id = playerID
        hand = []
    }
    var money:Int
    var id:Int
    var hand:Array<card>
    
     mutating func hit(var theDeck:deck) {
        hand.append(theDeck.draw())
    }
    func displayHand() -> String {
        var returnVal:String = ""
        for aCard in hand {
            returnVal = returnVal + "[" + aCard.value + aCard.suit + "]"
        }
        return returnVal
    }
    func evaluateHand() -> Int {
        var totalScore:Int = 0
        for aCard in hand {
            totalScore += scoreValues[aCard.value]!
        }
        return totalScore
    }
            
}
        
class deck{
    init() {
        cards = []
        rebuildDeck()
    }
    func rebuildDeck() {
        cards = []
        for suit in ["♠","♥","♦","♣"] {
            for value in 1...13			 {
                cards.append(card(theSuit:suit,theValue:value))
            }
        }

    }
    var cards:Array<card>
     func draw() -> card {
        if (cards.count == 0) {
            rebuildDeck() //possibility of redrawing cards already in play, but prevents crash when array empty
        }
        let cardNumber = Int(arc4random_uniform(UInt32(cards.count)))
        return cards.removeAtIndex(cardNumber)
    }
}
        
