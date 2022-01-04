const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ChildMintableERC721", function () {
  it("It should deploy the contract properly", async function () {
    const Child = await ethers.getContractFactory("ChildMintableERC721");
    const child = await Child.deploy("Test", "Test", ethers.constants.AddressZero);
  });
});
