pragma solidity 0.5.1;


contract ERC20Token {
	string public name;
	mapping (address => uint256) public balances;

	constructor(string memory _name){
		name = _name;
	}

	function mint() public {
		// ! doesn't work to use msg.sender her bc it will
		// be the address of the other smart contract. 
		balances[tx.origin]++;
	}
}

// INHERITANCE
contract MyToken is ERC20Token {
	string public symbol;
	address[] public owners;
	uint256 ownerCount;

	constructor(
				string memory _name, 
				string memory _symbol
	) 
	ERC20Token(_name) {
		symbol = _symbol;
	}

	function mint() public {
		super.mint();
		ownerCount++;
		owners.push(msg.sender);
	}
}

contract UseEther {
    address payable wallet;
    address token;

    constructor(address payable _wallet, address _token) public {
        wallet = _wallet;
        token = _token;
    }

	function() external payable {
		buyToken()
	}

    function buyToken() public payable {
        ERC20Token _token = ERC20Token(address(token))
		_token.mint();
    	// OR ERC20Token(address(token)).mint();
        wallet.transfer(msg.value);
    }
}
