const hre = require("hardhat");

async function main() {
  const Child = await hre.ethers.getContractFactory("ChildMintableERC721");
  const child = await Child.deploy(
    "ZestyFrens",
    "FRENS",
    "0xb5505a6d998549090530911180f38aC5130101c6"
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
