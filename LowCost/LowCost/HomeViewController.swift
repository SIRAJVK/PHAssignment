//
//  HomeViewController.swift
//  LowCost
//
//  Created by SIRAJ V K on 07/02/18.
//  Copyright © 2018 SIRAJ V K. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

  
   @IBOutlet weak var tblViewWeight:UITableView?
   
    @IBOutlet weak var lblIsTherePath:UILabel?
    @IBOutlet weak var lblPath:UILabel?
    @IBOutlet weak var lblPathTotalCost:UILabel?
    var rows = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAddRowAction(sender: UIButton) {
        rows.append("")
        self.tblViewWeight?.reloadData()
    }
    
    @IBAction func btnDeleteRowAction(sender: UIButton) {
        if rows.count > 0{
            rows.removeLast()
        }
        self.tblViewWeight?.reloadData()
    }

    @IBAction func findMinimumCostPath(sender:UIButton) {
        
        let mt = generateMatrixFromInput(source: rows)
        let lcf = LowestCostFinder(costMatrix:mt)

        
        let (success, lowestcost, path) = lcf.findFrom(costMatrix: mt)
        self.lblPath?.text = "\(path.map{ String($0)}.joined(separator: " "))"
        self.lblIsTherePath?.text = success ? "\("YES")" : "\("NO")"
        self.lblPathTotalCost?.text = "\(lowestcost)"

    }
    func generateMatrixFromInput(source:[String]) -> CostMatrix{
        var mt = [[Int]]()
        for rw in source {
           
            let colStrings = rw.components(separatedBy: " ")
            mt.append(colStrings.map() { x in Int(x) ?? 0 })
        }
        return CostMatrix(matrix: mt)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell") as! InputCell
        cell.lblRow?.text = "Row \(indexPath.row+1)"
        cell.txtFieldInput?.tag = 100 + indexPath.row
        cell.txtFieldInput?.text = "\(rows[indexPath.row])"
        cell.txtFieldInput?.delegate = self
        return cell
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        rows[textField.tag-100] = (textField.text ?? "")

    }
    
   
    
}

