import { ethers } from 'hardhat';

async function main() {
  const agreementFactory = await ethers.deployContract('AgreementFactory');

  await agreementFactory.waitForDeployment();

  console.log('Agreement factory deployed at ' + agreementFactory.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});