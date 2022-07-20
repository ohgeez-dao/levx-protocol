// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

interface IWrappedERC721 is IERC165, IERC721, IERC721Metadata {
    function PERMIT_TYPEHASH() external view returns (bytes32);

    function PERMIT_ALL_TYPEHASH() external view returns (bytes32);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function nftContract() external view returns (address);

    function tokenURIRenderer() external view returns (address);

    function admin() external view returns (address);

    function sales(uint256 tokenId, address owner)
        external
        view
        returns (
            uint256 price,
            address currency,
            uint64 deadline,
            bool auction
        );

    function currentBids(uint256 tokenId, address owner)
        external
        view
        returns (
            uint256 price,
            address bidder,
            uint64 timestamp
        );

    function offers(
        uint256 tokenId,
        address taker,
        address maker
    )
        external
        view
        returns (
            uint256 price,
            address currency,
            uint64 deadline,
            bool auction
        );

    function listForSale(
        uint256 tokenId,
        uint256 price,
        address currency,
        uint64 deadline,
        bool auction
    ) external;

    function cancelListing(uint256 tokenId) external;

    function buyETH(uint256 tokenId, address owner) external payable;

    function buy(
        uint256 tokenId,
        address owner,
        uint256 price
    ) external;

    function bidETH(uint256 tokenId, address owner) external payable;

    function bid(
        uint256 tokenId,
        address owner,
        uint256 price
    ) external;

    function claim(uint256 tokenId, address owner) external;

    function makeOfferETH(uint256 tokenId, uint64 deadline) external payable;

    function makeOffer(
        uint256 tokenId,
        uint256 price,
        address currency,
        uint64 deadline
    ) external;

    function withdrawOffer(uint256 tokenId, address taker) external;

    function acceptOffer(uint256 tokenId, address maker) external;

    function permit(
        address spender,
        uint256 tokenId,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function permitAll(
        address owner,
        address spender,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event ListForSale(
        uint256 indexed tokenId,
        address indexed owner,
        uint256 price,
        address currency,
        uint64 deadline,
        bool indexed auction
    );
    event CancelListing(uint256 indexed tokenId, address indexed owner);
    event MakeOffer(
        uint256 indexed tokenId,
        address indexed taker,
        address indexed maker,
        uint256 price,
        address currency,
        uint256 deadline
    );
    event WithdrawOffer(uint256 indexed tokenId, address indexed taker, address indexed maker);
    event AcceptOffer(
        uint256 indexed tokenId,
        address indexed taker,
        address indexed maker,
        uint256 price,
        address currency,
        uint256 deadline
    );
    event Buy(uint256 indexed tokenId, address indexed owner, address indexed bidder, uint256 price, address currency);
    event Bid(uint256 indexed tokenId, address indexed owner, address indexed bidder, uint256 price, address currency);
    event Claim(
        uint256 indexed tokenId,
        address indexed owner,
        address indexed bidder,
        uint256 price,
        address currency
    );
}
