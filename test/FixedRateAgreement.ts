import {
    time,
    loadFixture,
  } from "@nomicfoundation/hardhat-toolbox/network-helpers";
  import { expect } from "chai";
  import hre from "hardhat";
  
  describe("Agreement factory", function () {
    // We define a fixture to reuse the same setup in every test.
    // We use loadFixture to run this setup once, snapshot that state,
    // and reset Hardhat Network to that snapshot in every test.
    async function deployAgreementFactory() {
  
      // Contracts are deployed using the first signer/account by default
      const [owner, otherAccount] = await hre.ethers.getSigners();
  
      const FixedRateAgreement = await hre.ethers.getContractFactory("AgreementFactory");
      const fixedRateAgreement = await FixedRateAgreement.deploy();

      console.log(owner.toJSON(), 'the owner address')
  
      return { owner, otherAccount, agreementFactory: fixedRateAgreement };
    }
  
    describe("Deployment", function () {
      it("deploy successfully", async function () {
        const {owner, otherAccount, agreementFactory} = await loadFixture(deployAgreementFactory);
  
        expect(owner).to.not.equal(undefined);
        // expect(owner).to.equal(unlockTime);
      });
    });

    describe("agreement creation", function(){
        it("should deploy a fixed rate agreement successfully", async function (){
            const {owner, otherAccount, agreementFactory} = await loadFixture(deployAgreementFactory);
            await agreementFactory.createNewFixedRateAgreement(
                'employer id',
                'employee id',
                owner.address,
                otherAccount.address,
                100000
            )
            expect(await agreementFactory.getNumberOfFixedRateAgreements()).to.above(0)
        })

        it("should deploy a pay as you go agreement successfully", async function (){
            const {owner, otherAccount, agreementFactory} = await loadFixture(deployAgreementFactory);
            await agreementFactory.createNewPayAsYouGoAgreement(
                'employer id',
                'employee id',
                owner.address,
                otherAccount.address,
                100000
            )
            expect(await agreementFactory.getNumberOfPayAsYouGoAgreements()).to.above(0)
        })
    })
  });
  