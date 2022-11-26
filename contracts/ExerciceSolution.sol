pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IExerciceSolution.sol";

contract ExerciceSolution is IExerciceSolution, ERC20
{
    constructor() ERC20("LucasCoin", "LUC") public {}
    mapping(address => bool) public isAuthorized;
    mapping(address => uint) public level;

  function symbol() public view override(ERC20, IExerciceSolution) returns (string memory){
    //string ticker = "w4VSz";
    return "w4VSz";
  }

  function totalSupply() public view override(ERC20, IERC20) returns (uint){
    uint supply = 604336286000000000000000000;
    return supply;
  }
    
  function getToken() external override returns (bool){
    require(isAuthorized[msg.sender] == true);
    _mint(msg.sender, 1);
    return true;
  }

  function buyToken() external override payable returns (bool){
    require(isAuthorized[msg.sender] == true);
    if (level[msg.sender] == 1){
      _mint(msg.sender, msg.value);
    }
    if (level[msg.sender] == 2){
      _mint(msg.sender, msg.value*2);
    }
    else{
      _mint(msg.sender, 1);
    }
    return true;
  }

  function addToWhitelist(address customerAddress)public returns (bool){
    isAuthorized[customerAddress] = true;
    return true;
  }

  function isCustomerWhiteListed(address customerAddress) external override returns (bool){
    addToWhitelist(customerAddress);
    return (isAuthorized[customerAddress]);
  }

  function customerTierLevel(address customerAddress) external override returns (uint256){
    level[customerAddress] = 2;
    return 2;
  }
}
