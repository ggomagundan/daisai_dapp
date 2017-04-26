solidity ^0.4.10;

contract Daisai {

  unit public maxBetLimit;
  unit public minBetLimit;


  function betDaisai(uint betValue, address betAddress) constant returns (uint betTimestamp){

    // Bet Too Low Or Too High
    if (betValue < minimumBet || msg.value > maximumBet) throw;

    // Bet More Then User Balance
    if (betValue > address(this).balance) throw;

    timestamp = Time.now()

  }

  function returnWinnerBets(){
    winner.send(winner.betValue * 2);
  }

  function setNewGame(){

    returnWinnerBets();

  }

}
