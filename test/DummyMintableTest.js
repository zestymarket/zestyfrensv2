const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DummyMintableERC721", function () {
  it("It should deploy the contract properly", async function () {
    const Dummy = await ethers.getContractFactory("DummyMintableERC721");
    const dummy = await Dummy.deploy("Test", "Test", ethers.constants.AddressZero);
  });
});
