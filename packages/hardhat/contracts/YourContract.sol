// SPDX-License-Identifier: GPL-3.0

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

pragma solidity >=0.8.0 <0.9.0;

contract YourContract is ERC20 {

    struct Post {
        address userId;
        uint256 timestamp;
        string emotion;
        string message;
    }

    event NewPost(address indexed userId, uint256 postIndex, string emotion, string message);

    mapping(address => uint256) balances;
    uint256 totalSupply_;
    address public owner;
    Post[] public posts;

    constructor() ERC20("VirtualHUg", "VT") {
        owner = msg.sender;
    }
    function createPost(string calldata emotion, string calldata message) external {
        posts.push(Post({
            userId: msg.sender,
            timestamp: block.timestamp,
            emotion: emotion,
            message: message
        }));
        _mint(msg.sender, 5 * 10 ** decimals());
        emit NewPost(msg.sender, posts.length - 1, emotion, message);
    }

    function getPostCount() external view returns (uint256) {
        return posts.length;
    }

    function getPost(uint256 index) external view returns (Post memory) {
        require(index < posts.length, "Post index out of bounds");
        return posts[index];
        }
}
