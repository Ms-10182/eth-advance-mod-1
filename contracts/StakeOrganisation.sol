// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StakeOrganisation is ERC20,Ownable{
    constructor(string memory _org,string memory _token) ERC20(_org,_token)Ownable(msg.sender){
        //
        vestingSchedules[MemType.community] = type(uint256).max;
        vestingSchedules[MemType.investors] = type(uint256).max;
        vestingSchedules[MemType.pre_sale_buyers] = type(uint256).max;
        vestingSchedules[MemType.founders] = type(uint256).max;
        
    }

    enum MemType{community, investors, pre_sale_buyers, founders}
    

    struct Member {
        MemType memType;
        uint256 amount;
        bool whitelisted;
        uint256 vestingStartTime;
        bool claimed;
    }

    mapping(MemType=>uint)public vestingSchedules;
    mapping(address => Member) public members;

    event MemberAdded(address indexed memberAddress, MemType memType, uint256 amount);
    event MemberWhitelisted(address indexed memberAddress);
    event TokensClaimed(address indexed memberAddress, uint256 amount);
    
    function setVestingSchedule(uint _community, uint _investors, uint _pre_sale_buyers, uint _founders)public onlyOwner{
        vestingSchedules[MemType.community] = _community;
        vestingSchedules[MemType.investors] = _investors;
        vestingSchedules[MemType.pre_sale_buyers] = _pre_sale_buyers;
        vestingSchedules[MemType.founders] = _founders;
    }

    function addMember(address _memAddress, MemType _type, uint256 _amount) public onlyOwner {
        require(members[_memAddress].amount == 0, "Member already exists");
        members[_memAddress] = Member(_type, _amount, false, block.timestamp, false);
        _mint(address(this), _amount); 
        emit MemberAdded(_memAddress, _type, _amount);
    }

    function whiteListingMem(address _memAddress)public onlyOwner {
        members[_memAddress].whitelisted = true;
        emit MemberWhitelisted(_memAddress);

    }

    function claimToken(address _memAddress) public {
        Member storage member = members[_memAddress];
        require(member.whitelisted, "Not whitelisted");
        require(!member.claimed, "Tokens already claimed");
        require(block.timestamp >= member.vestingStartTime + vestingSchedules[member.memType], "Vesting period not over");

        member.claimed = true;
        _transfer(address(this), _memAddress, member.amount);
        members[_memAddress].amount =0;
        emit TokensClaimed(_memAddress, member.amount);
    }

    function getTime()public view returns (uint){
        return block.timestamp;
    }

}