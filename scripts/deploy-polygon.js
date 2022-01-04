const hre = require("hardhat");

async function main() {
  const Child = await hre.ethers.getContractFactory("ChildMintableERC721");
  const child = await Child.deploy(
    "ZestyFrens",
    "FRENS",
    "0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa"
  );

  await child.deployed();

  console.log("ChildMintableERC721 deployed to:", child.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
