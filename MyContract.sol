pragma solidity ^0.7;

contract MyContract {
    string public stringValue = "MyValue";
    string public constant constantValue = "MyValue";
    bool public myBool = true;
    int256 public myInt = 1;
    uint256 myUint = 1;
    uint8 myUint8 = 8;

    function set(string memory _value) public {
        stringValue = _value;
    }
}

contract EnumContract {
    enum State {Waiting, Ready, Active}
    State public state = State.Waiting;

    function activate() public {
        state = State.Active;
    }

    // view?
    function isActive() public view returns (bool) {
        return state == State.Active;
    }
}

contract StructContract {
    Person[] public people;

    uint256 peopleCount;

    struct Person {
        string _firstName;
        string _lastName;
    }

    function addPerson(string memory _firstName, string memory _lastName)
        public
    {
        people.push(Person(_firstName, _lastName));
        peopleCount++;
    }
}

contract MappingContract {
    mapping(uint256 => Person) public people;
    uint256 peopleCount = 0;
    uint256 openingTime = 1627553607;

    address owner;

    modifier onlyOwner() {
        require(block.timestamp >= openingTime);
        _;
    }

	// only possible to interact while open, for crowd seller or ICO 
	modifier onlyWhileOpen() {
		require(msg.sender == owner);
		_;
	}

    struct Person {
        uint256 _id;
        string _firstName;
        string _lastName;
    }

    constructor() {
        owner = msg.sender;
    }

    function addPerson(string memory _firstName, string memory _lastName)
        public
        onlyOwner
    {
        incrementCount();
        people[peopleCount] = Person(peopleCount, _firstName, _lastName);
    }

    function incrementCount() internal {
        peopleCount += 1;
    }
}
