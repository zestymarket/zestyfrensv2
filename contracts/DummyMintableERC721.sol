pragma solidity >=0.6.0;

import "./utils/ERC721.sol";
import "./utils/AccessControlMixin.sol";
import "./utils/NativeMetaTransaction.sol";
import "./utils/IMintableERC721.sol";
import "./utils/ContextMixin.sol";


// Deploy on Mainnet
contract DummyMintableERC721 is
    ERC721,
    AccessControlMixin,
    NativeMetaTransaction,
    IMintableERC721,
    ContextMixin
{
    bytes32 public constant PREDICATE_ROLE = keccak256("PREDICATE_ROLE");

    // Mainnet
    // "MintableERC721PredicateProxy" : "0x932532aA4c0174b8453839A6E44eE09Cc615F2b7"
    // Goerli
    // "MintableERC721PredicateProxy" : "0x56E14C4C1748a818a5564D33cF774c59EB3eDF59"
    constructor(
        string memory name_, 
        string memory symbol_,
        address predicateProxy
    )
        public
        ERC721(name_, symbol_)
    {
        _setupContractId("DummyMintableERC721");
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(PREDICATE_ROLE, predicateProxy);
        _initializeEIP712(name_);
    }

    function _msgSender()
        internal
        override
        view
        returns (address payable sender)
    {
        return ContextMixin.msgSender();
    }

    /**
     * @dev See {IMintableERC721-mint}.
     */
    function mint(address user, uint256 tokenId) external override only(PREDICATE_ROLE) {
        require(tokenId < 10000, "Invalid TokenId");
        _mint(user, tokenId);
    }

    /**
     * If you're attempting to bring metadata associated with token
     * from L2 to L1, you must implement this method, to be invoked
     * when minting token back on L1, during exit
     */
    function setTokenMetadata(uint256 tokenId, bytes memory data) internal virtual {
        // This function should decode metadata obtained from L2
        // and attempt to set it for this `tokenId`
        //
        // Following is just a default implementation, feel
        // free to define your own encoding/ decoding scheme
        // for L2 -> L1 token metadata transfer
        string memory uri = abi.decode(data, (string));

        _setTokenURI(tokenId, uri);
    }

    /**
     * @dev See {IMintableERC721-mint}.
     * 
     * If you're attempting to bring metadata associated with token
     * from L2 to L1, you must implement this method
     */
    function mint(address user, uint256 tokenId, bytes calldata metaData) external override only(PREDICATE_ROLE) {
        require(tokenId < 10000, "Invalid TokenId");
        _mint(user, tokenId);

        setTokenMetadata(tokenId, metaData);
    }


    /**
     * @dev See {IMintableERC721-exists}.
     */
    function exists(uint256 tokenId) external view override returns (bool) {
        return _exists(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI) public only(DEFAULT_ADMIN_ROLE) {
        _setTokenURI(tokenId, tokenURI);
    }

    function setBaseURI(string memory baseURI) public only(DEFAULT_ADMIN_ROLE) {
        _setBaseURI(baseURI);
    }

    function setContractURI(string memory contractURI) public only(DEFAULT_ADMIN_ROLE) {
        _setContractURI(contractURI);
    }
}