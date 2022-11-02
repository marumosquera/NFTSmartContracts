# NFTSmartContracts - Solidity Internship


## Practice Smart Contract #1
**Requirements**
- Must be compatible with ERC721
- Must be able to add multiple contract admins, who can access admin-only functions
- Contract must be pausable by admins (no transfers, mints or burns when contract is
- paused)
- Must support EIP2981 NFT Royalty Standard
- Must have a private sale that goes for 24 hours (only addresses on an allowlist can
- mint during this sale)
- Must have a public sale that goes for 48 hours or until all tokens are minted
- Must have a maximum supply of 10000
- Tokens must cost 0.01 Ether during the private sale and 0.03 during the public sale
- Must have a wallet cap (limit per wallet) of 2 for the private sale, and 5 for the public
- sale
- Base URI must change every day - loops every 3 days:


## Practice Smart Contract #2
**Requirements**

- Must use ERC721A by Chiru Labs
- Must be able to add multiple contract admins, who can access admin-only functions
- Contract must be pausable by admins (no transfers, mints or burns when contract is
- paused)
- Must support EIP2981 NFT Royalty Standard
- Must have a public sale that goes for 48 hours or until all tokens are minted
- Must have a maximum supply of 1000
- Tokens must cost 0.01 Ether
- Sale must have a limit of 5 token mints per wallet
- Users must be able to mint multiple tokens in a single transaction
- Must have a withdrawal function for admins to withdraw funds from the contract
- Token metadata should be returned on-chain, including the following attributes:
		 Token name ( name )
		 Token description ( description )
		 Creator name ( created_by )
		 Image url ( image )
		 Animation url ( animation )
- A custom attribute which shows how many times that token has been
- transferred
- The image url and animation url for each token should use the standard base URI
