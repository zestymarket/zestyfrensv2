const hre = require("hardhat");

async function main() {
  const Dummy = await hre.ethers.getContractFactory("DummyMintableERC721");
  const dummy = await Dummy.deploy(
    "ZestyFrens",
    "FRENS",
    "0x56E14C4C1748a818a5564D33cF774c59EB3eDF59"
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
