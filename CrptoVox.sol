pragma solidity ^0.5.0;

// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
// ----------------------------------------------------------------------------
contract ERC20Interface {
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}


contract CryptoVox is ERC20Interface {
    string public name = "CryptoVox";
    string public symbol = "CRVOX";
    uint public decimal = 18;
    
    uint private _supply;
    address public creator;
    
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowed;
    
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    
    constructor(uint _initialSupply) public {
        creator = msg.sender;
        _supply = _initialSupply;
        balances[creator] = _supply;
    }
    
    function totalSupply() public view returns (uint) {
        return _supply;    
    }
    
    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }
    
    
    function transfer(address to, uint tokens) public returns (bool success) {
        require(tokens > 0 && balances[msg.sender] >= tokens, "Insufficient token");
        balances[to] += tokens;
        balances[msg.sender] -= tokens;
        
        emit Transfer(msg.sender, address(balances[to]), tokens);
        return true;
    }
    
    
    function allowance(address tokenOwner, address spender) public view returns (uint remaining){
        return allowed[tokenOwner][spender];
    }
   
    function approve(address spender, uint tokens) public returns (bool success) {
        require(balances[msg.sender] >= tokens && tokens > 0,"Insufficient token");
        allowed[msg.sender][spender] = tokens;
        
        emit Approval(msg.sender, address(spender), tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        require(allowed[from][to] >= tokens,"Insufficient token");
        require(balances[from] >= tokens && tokens > 0,"Insufficient token");
        balances[from] -= tokens;
        balances[to] += tokens;
        allowed[from][to] -= tokens;
        return true;
        
    }
    
}