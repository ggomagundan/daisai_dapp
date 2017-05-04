pragma solidity ^0.4.10;

contract Daisai {

  mapping(address=>bool) public owners;
  address public owner; 

  uint public maxBetLimit;
  uint public minBetLimit;
  uint public totalCount =0;
  uint public timestamp;
 
  string  public version = "0.1.0";
 
   struct  BetAccount {
 
    address betAddress;
    uint betLocation; // Bet Location (Odd, Event...)
    uint betValue; // rewards balance
    uint timestamp;
} 
 
 // mapping (address => BetAccount ) betAccounts ; 
  BetAccount[] betAccounts;
  


  function  betDaisai(uint betValue, address betAddress)  payable{

    // Bet Too Low Or Too High 
    if (betValue < minBetLimit || msg.value > maxBetLimit) throw;

    // Bet More Then User Balance
    if (betValue > address(this).balance) throw;
 
     BetAccount memory bet = BetAccount(betAddress, 1, betValue, now) ;
    betAccounts.push(bet);
    
  }

  function returnWinnerBets(){ 
   for (uint index = 0; index < betAccounts.length; index++) {
    BetAccount winner = betAccounts[index];
    winner.betAddress.transfer(winner.betValue * 2);
   }
  }

  function setNewGame(){
    
    returnWinnerBets();
    totalCount = 0;
    
  }

}
