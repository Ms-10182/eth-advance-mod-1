# Organisation Stakes
This fullstack code is made for an organization register and to create a vesting schedule for their tokens. Depending on the tokenomics model of a web3 organization
## Description
### Smart contract part
This contract is written in Solidity language, a programming language used for developing smart contracts on the Ethereum blockchain. constructor defines the organisation name and initialize the vesting schedule all as max int to avoid early claim. enum ```MemType{community, investors, pre_sale_buyers, founders}``` defines the stakeholders of the organisation. ```struct Member``` hold the metadata of the members. vestingschedules are mapped with int for its timeperion and address is mapped with enum for track of stakeholders. ```event``` are used for logging purpose. ```setVestingSchedule()``` is onlyOwner and is used to set the vesting schedule of the oraganisation. ```addMember()``` adds new member with stakeholder type and amount. This is also only owner. ```whiteListingMem()``` is only owner function that will set the stakholder as whitelisted and only they can receive the tokens. Last onlyOwner function ```claimToken()``` will transfer the token to the stakeholder when if all the criteria are met. ```getTime()``` and ```getTokens()``` will return time stakeholder's token respectively.
### Front end part
```index.html``` and ```styles.css``` is used to create and design the structure and look of the front end and app.js is used for the logic purpose. In js file we have contract address, abi. Using this with ethers.js we get create the provider, signer and contract. then ```connectWallet()``` is used to connect the wallet. and rest all the functions are connected with the solidity functions.

## Getting Started

### Executing program

To run this program:
1) create new directory and run 
```javascript
git clone 
cd directory
```
2) In remix IDE create new .sol file copy and paste the code of ```StakeOrganisation.sol``` into it. select injected metamask and any testnet.
3) Pass the organisation name and token name as arguments and deploy the contract from left side panel of remix IDE.

4) Copy the address of smart contract and paste in value of ```contractAddress``` in ```app.js```.

5) Copy the abi from complie tab in remix and paste in value of ```contractABI``` in ```app.js```.

6) In the project folder run the index.html file in browser.

Steps to interact with the UI.(switch to owner in metamask same as remix)
1) click connect wallet.
2) enter the vesting schedule and click the set button.
3) add any memner and define their stakeholding role.
4) whitelist members accodingly.
5) when the vesting period is over claim the token of the address, which will actually transfer the tokens from contract to the stakeholder's address.
6) you can check token to stakeholders by clicking ```check tokens``` and can check the time by clicking ```click to check time```.




## Authors

Mayank Sharma  
[@Mayank](https://www.linkedin.com/in/mayank-sharma-078278243/)


## License

This MyToken is licensed under the MIT License 
