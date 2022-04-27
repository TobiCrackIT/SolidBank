//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


interface cETH {
    
    function mint() external payable; // to deposit to compound
    function redeem(uint redeemTokens) external returns (uint); // to withdraw from compound
    
    //following 2 functions to determine how much you'll be able to withdraw
    function exchangeRateStored() external view returns (uint); 
    function balanceOf(address owner) external view returns (uint256 balance);
}


contract SolidBank {


    uint totalContractBalance = 0;
    
    //Compound ETH cETH contract address
    address COMPOUND_CETH_ADDRESS = 0x859e9d8a4edadfEDb5A2fF311243af80F85A91b8;
    cETH ceth = cETH(COMPOUND_CETH_ADDRESS);

    function getContractBalance() public view returns(uint){
        return totalContractBalance;
    }
    
    mapping(address => uint) balances;
    
    function addBalance() public payable {
        
        // send ethers to mint()
        ceth.mint{value: msg.value}();

        balances[msg.sender] = balances[msg.sender] + calculateBalances();
        
    }

    function calculateBalances() public returns(uint256) {
        uint oldBalance = getContractBalance();
        totalContractBalance = ceth.balanceOf(address(this));

        return totalContractBalance - oldBalance;
    }


    // functions to receive ether
    receive() external payable {}

    fallback() external payable {}
    
    function getBalance(address userAddress) public view returns(uint256) {
        return balances[userAddress] * ceth.exchangeRateStored() / 1e18;
    }


    function withdraw() public payable {
        
        //Address to withdraw ETH into
        address payable withdrawTo = payable(msg.sender);

        uint amount = getBalance(msg.sender);

        ceth.redeem(amount);

        (bool sent, ) = withdrawTo.call{value: amount}("");
        require(sent, "Failed to send ether");
        totalContractBalance -= balances[msg.sender];
        balances[msg.sender] = 0;
    }

}