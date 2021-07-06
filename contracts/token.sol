pragma solidity ^0.5.16;

import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/token/ERC20/ERC20.sol";
import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/ownership/Ownable.sol";

contract DEMO is ERC20, ERC20Detailed, Ownable{
    using SafeMath for uint;
  
    address public ownerAddress;
    uint256 public lastClaimedAt;
    uint256 public currentSupply=0;
    uint256 public maxSupply=1e25;//10 million maximum supply
    uint256 fixedTime=157784630;// 5 years in seconds
    uint256 elapsedTime;
     

    constructor () public ERC20Detailed("DEMO", "DM", 18) {
        ownerAddress=msg.sender;
        lastClaimedAt=block.timestamp;
        elapsedTime=block.timestamp.sub(lastClaimedAt);
    }

    function claim() public payable onlyOwner {
        require(currentSupply<maxSupply, "NO MAS");
        uint256 total=maxSupply.sub(currentSupply);
        uint256 mintAmount=total.div(fixedTime);
        uint256 tokens;
        elapsedTime=block.timestamp.sub(lastClaimedAt);
        if (fixedTime>elapsedTime) {
            tokens=mintAmount.mul(elapsedTime);
            fixedTime=fixedTime.sub(elapsedTime);
        }
        else if (fixedTime<elapsedTime) {
            tokens=total;
        }
        _mint(ownerAddress, tokens);
        currentSupply=currentSupply.add(tokens);
        lastClaimedAt=block.timestamp;
    }
}
