const hre = require("hardhat");

async function main() {
  const Dummy = await hre.ethers.getContractFactory("DummyMintableERC721");
  const dummy = await Dummy.deploy(
    "ZestyFrens",
    "FRENS",
    "0x932532aA4c0174b8453839A6E44eE09Cc615F2b7"
  );

  await dummy.deployed();

  console.log("DummyMintableERC721 deployed to:", dummy.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
