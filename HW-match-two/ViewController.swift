//
//  ViewController.swift
//  HW-match-two
//
//  Created by Zhazira Yesmakhanova on 17.06.2023.
//

import UIKit

class ViewController: UIViewController {
    var winState = [[1, 12], [2, 16], [3, 10], [4, 14], [5, 11], [6, 13], [7, 9], [8, 15]]
    var userSelect: [Int] = []
    var winArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSteps.text = String(steps)
        timer.text = String(time)
    }
    
    @IBAction func touched(_ sender: UIButton) {
        
        if sender.tag == 1 || sender.tag == 12 {
            sender.setBackgroundImage(UIImage(named: "nancy"), for: .normal)
        } else if sender.tag == 2 || sender.tag == 16 {
            sender.setBackgroundImage(UIImage(named: "amsterdam"), for: .normal)
        } else if sender.tag == 3 || sender.tag == 10 {
            sender.setBackgroundImage(UIImage(named: "berlin"), for: .normal)
        } else if sender.tag == 4 || sender.tag == 14 {
            sender.setBackgroundImage(UIImage(named: "budapest"), for: .normal)
        } else if sender.tag == 5 || sender.tag == 11 {
            sender.setBackgroundImage(UIImage(named: "oslo"), for: .normal)
        }  else if sender.tag == 6 || sender.tag == 13 {
            sender.setBackgroundImage(UIImage(named: "copenhagen"), for: .normal)
        }  else if sender.tag == 7 || sender.tag == 9 {
            sender.setBackgroundImage(UIImage(named: "paris"), for: .normal)
        }  else if sender.tag == 8 || sender.tag == 15 {
            sender.setBackgroundImage(UIImage(named: "stocholm"), for: .normal)
        }
        
        userSelect.append(sender.tag)
        if userSelect.count == 2 {
            steps += 1
            updateSteps()
            if winState.contains(userSelect) {
                for element in userSelect {
                    if !winArray.contains(element) { //нужно для того, чтобы не записывать по несколько раз уже открытую выигрышную комбинацию. Это влияет на проверку в конце для вывода алерта об окончании игры
                        winArray.append(element)
                    }
                }
                clearStep()
            } else if winState.contains(userSelect.reversed()) { //new info -- Collection.contains(Collection.reversed()) -- засчитывает выигрышную комбинацию на случай если пользователь нажал кнопки наоборот
                for element in userSelect {
                    if !winArray.contains(element) { //нужно для того, чтобы не записывать по несколько раз уже открытую выигрышную комбинацию. Это влияет на проверку в конце для вывода алерта
                        winArray.append(element)
                    }
                }
                clearStep()
            } else {
                for element in userSelect {
                    if winArray.contains(element) {
                        userSelect.removeAll(where: { $0 == element }) //new info -- removeAll(where: { $0 == element}) -- идет проверка на наличие выигрышных комбинаций(которые уже были открыты и сохранены в winArray) в нажатых ячейках, и если они есть там, то мы просим удалить их для того, чтобы оно не закрылось вместе с НЕвыигрышной ячейкой
                    }
                }
                let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in //задерживает
                    for select in self.userSelect {
                        if let button = self.view.viewWithTag(select) as? UIButton {
                            clear(button)
                            clearStep()
                        }
                    }
                }
            }
        }
        print(steps)
        print(winArray)
        
        if winArray.count == 16 {
            let alert = UIAlertController(title: "You win!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Start again", style: .default, handler: {
                UIAlertAction in
                clearGame()
            }))
            alert.addAction(UIAlertAction(title: "Finish", style: .default, handler: {
                UIAlertAction in
            }))
            present(alert, animated: true, completion: nil)
        }
        
        //clear steps in order to choose new ones:
        func clearStep() {
            userSelect = []
        }
        
        //clear the button after mismatch:
        func clear(_ sender: UIButton) {
            sender.setBackgroundImage(nil, for: .normal)
        }
        
        //clear the board after win/mismatch:
        func clearGame() {
            for i in 0...15 {
                winArray[i] = 0
                let button = view.viewWithTag(i + 1) as! UIButton
                button.setBackgroundImage(nil, for: .normal)
            }
            winArray = []
            steps = 0
        }
    }
    
    @IBOutlet weak var showSteps: UILabel!
    var steps = 0
        func updateSteps() {
            showSteps.text = String(steps)
        }
    
    @IBOutlet weak var timer: UILabel!
        var time = 0
        var countT = Timer()
        func countTime() {
            timer.text = String(time)
        }
    
    
    
}
