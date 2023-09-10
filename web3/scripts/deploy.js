const hre = require("hardhat");

async function main() {
  //STACKING
  const tokenStaking = await hre.ethers.deployContract("TokenStaking");

  await tokenStaking.waitForDeployment();

  console.log(` STACKING: ${tokenStaking.target}`);
  //TOKEN
  const albertols = await hre.ethers.deployContract("Thealbertols");

  await albertols.waitForDeployment();

  //CONTRACT ADDRES

  console.log(` STACKING: ${tokenStaking.target}`);
  console.log(` TOKEN: ${albertols.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
