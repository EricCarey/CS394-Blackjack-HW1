//
//  ViewController.swift
//  Mobile App Dev. Project
//
//  Created by Deli-MAC on 3/3/15.
//  Copyright (c) 2015 Deli-MAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    var theDeck:deck!
    var players:Array<player>!
    var handCounter:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var dealer:player = player(playerID: 0)
        handCounter = 0
        players = []
        players.append(dealer)
        players.append(player(playerID: 1))
        theDeck = deck()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hitButton(sender: AnyObject) {
        players[1].hit(theDeck)
        myCards.text = players[1].displayHand()
        myScore.text = String(players[1].evaluateHand())
    }
    
    func bet() {
        
    }
    
    @IBAction func stayButton(sender: AnyObject) {
        var pot:Int = 1
        var p1hand = players[1].evaluateHand()
        var dealerhand = players[0].evaluateHand()
        dealerHand.text = players[0].displayHand()
        dealerScore.text = String(dealerhand)
        
        if ((p1hand < 22) && (dealerhand < 22)) {
            //neither bust
            if (dealerhand > p1hand) {
                //dealer wins
                players[1].money -= pot
            }
            else if (p1hand > dealerhand) {
                //player wins
                players[1].money += pot
            }
            else {
                //tie, nobody wins
            }
        }
        else if (dealerhand < 22) {
            //player busts, dealer wins
            players[1].money -= pot
        }
        else if (p1hand < 22) {
            //dealer busts, player wins
            players[1].money += pot
        }
        else {
            //both bust
            
        }
        myMoney.text = String(players[1].money)
        stayButtonOutlet.enabled = false
        if (players[1].money > 0) {
            startButtonOutlet.enabled = true
        }
        else {
            startButtonOutlet.setTitle("Not enough money to play!", forState: .Normal)
        }
        hitButtonOutlet.enabled = false
        
    }
    
    @IBAction func startButton(sender: AnyObject) {
        handCounter += 1
        if (handCounter == 5) {
            theDeck = deck() //shuffle deck
        }
        stayButtonOutlet.enabled = true
        startButtonOutlet.enabled = false
        hitButtonOutlet.enabled = true
        
        players[1].hand = []
        players[0].hand = []
        dealerHand.text = "[ ]"
        dealerScore.text = "?"
        myCards.text = "[ ]"
        myScore.text = "0"
        while (players[0].evaluateHand() < 17) {
            players[0].hit(theDeck)
        }
        players[1].hit(theDeck)
        players[1].hit(theDeck)
        myCards.text = players[1].displayHand()
        myScore.text = String(players[1].evaluateHand())


    }
    
    @IBOutlet weak var stayButtonOutlet: UIButton!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var hitButtonOutlet: UIButton!
    
    @IBOutlet weak var myMoney: UILabel!
    @IBOutlet weak var myScore: UILabel!
    @IBOutlet weak var myCards: UILabel!
    @IBOutlet weak var dealerHand: UILabel!
    @IBOutlet weak var dealerScore: UILabel!

}
//To Do:
//Functions: build deck,  bet, evaluate hand,  stay

//Done: Hit, get card,
//Vars: card, player, deck
