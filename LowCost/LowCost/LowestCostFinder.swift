//
//  LowestCostFinder.swift
//  LowCost
//
//  Created by SIRAJ V K on 07/02/18.
//  Copyright © 2018 SIRAJ V K. All rights reserved.
//

import Foundation
class LowestCostFinder{
    var costMatrix : CostMatrix
    init(costMatrix:CostMatrix){
        self.costMatrix = costMatrix
    }
    
    func findFrom(costMatrix:CostMatrix) -> (Bool, Int, Array<Int>) {
        if costMatrix.matrix.count == 0 {
            return (false, 0, [])
        }
        
        var lowest: (Bool, Int, Array<Int>)! = nil
        for row in 1...costMatrix.rows {
            let rowLeast = findFrom(matrix:costMatrix, 0, [], (row, 1))
            if (lowest == nil || rowLeast.1 < lowest.1) {
                lowest = rowLeast
            }
        }
        
        return lowest
    }
    
    private func findFrom(matrix: CostMatrix, _ prevCost: Int, _ prevPath: Array<Int>, _ XY: (Int, Int)) -> (Bool, Int, Array<Int>) {
        // Add the current XY to the previous path.
        let cost = prevCost + matrix.getCostAt(XY: XY)
        let (r, c) = XY
        let path = prevPath + [r]
        
        // Base cases that stop the recursion.
        if cost > 50 {
            return (false, prevCost, prevPath)
        } else if c == matrix.columns {
            return (true, cost, path)
        }
        
        // Calulate all possible paths from this point.
        let up = findFrom(matrix: matrix, cost, path, matrix.topXYFrom(XY: XY))
        let right = findFrom(matrix: matrix, cost, path, matrix.rightXYFrom(XY: XY))

        let down = findFrom(matrix: matrix, cost, path, matrix.bottomXYFrom(XY: XY))
        
        // Choose the least path from this point.
        if betterThan(up, right) && betterThan(up, down) {
            return up
        } else if betterThan(right, down) {
            return right
        } else {
            return down
        }
    }
    
    private func betterThan(_ lhs: (Bool, Int, Array<Int>), _ rhs: (Bool, Int, Array<Int>)) -> Bool {
        if lhs.2.count != rhs.2.count {
            return lhs.2.count > rhs.2.count
        } else {
            return lhs.1 <= rhs.1
        }
    }
}
