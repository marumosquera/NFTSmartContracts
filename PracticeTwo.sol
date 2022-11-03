// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//npm install --save-dev erc721a
import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";

contract PracticeTwo is ERC721A {

    bool public paused;

    mapping(address => bool) public admins;
    mapping (address => uint) pendingWithdrawals;

    address private royaltyRecipient;
    uint256 public saleLength = 172800;
    uint256 public maxSupply = 1000;
    uint256 public price = 0.01 ether;
    uint256 public walletCap = 5;
    uint256 public saleTimestamp;


     constructor() ERC721A("MyToken", "MTK") {
        admins[msg.sender] = true;
        royaltyRecipient = msg.sender;
    }

    modifier restricted() {
        require(admins[msg.sender], "Caller is not admin");
        _;
    }

    modifier whenNotPaused() {
    require(!paused, "Contract is currently paused");
    _;
    }

    //ADMINS ONLY

    function togglePause() external restricted {
        paused = !paused;
    }

    function toggleAdmins(address account) external restricted {
        admins[account] = !admins[account];
    }

    function beginSale() external restricted {
        saleTimestamp = block.timestamp;
    }

    //ON CHAIN METADATA

   function tokenURI(uint256 tokenId) public view override(ERC721A) returns (string memory){
    super.tokenURI(tokenId);

    return string(
        abi.encodePacked(
            '{"name":"token name"',
            '"description":"token name"',
            '"created_by":"token name"',
            '"image":"token name"',
            '"animation":"token name"',
            '"attribute":"token name"}'
        )
    );

   }

    //MINT && BURN

    function publicMint(uint256 amount) external payable whenNotPaused {
        require(
            // sale timestamp must not be 0
            saleTimestamp != 0 &&
            // sale timestamp must be in the past
            block.timestamp > saleTimestamp &&
            // sales have not concluded
            block.timestamp < saleTimestamp + saleLength,
            "Sale is not available now"
        );
        require(totalSupply() + amount <= maxSupply, "Not enough tokens remaining");      
        require(msg.value == price * amount, "Incorrect amount of Ether sent");
        require(amount + _numberMinted(msg.sender) <= walletCap, "Exceeds wallet capacity");
        
       
        _safeMint(msg.sender, amount);

    }

    function burn(uint256 tokenId, bool approvalCheck) external whenNotPaused {
        _burn(tokenId, approvalCheck);
    }

    //WITHDRAW

//     function withdraw() public payable restricted {
//       uint amount = pendingWithdrawals[msg.sender];
//       pendingWithdrawals[msg.sender] = 0;
//       msg.sender.transfer(amount);
//    }

   //EIP2981

     function royaltyInfo(uint256, uint256 salePrice)
        external
        view
        returns (address receiver, uint256 royaltyAmount)
    {
        return (royaltyRecipient, salePrice / 10);
    }



}