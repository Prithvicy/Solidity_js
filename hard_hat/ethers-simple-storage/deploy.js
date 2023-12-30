//synchornous [solidity]
//asynchronous [javascript]

//Promise can be either pending , filled or rejectd state

// async function setupMOvieNigth(){
//   await cookPopcorn();
//   await pourDrinks();
//   strtMovie();
// }

const ethers = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();
async function main() {
  //compile in our code
  //compile them seperately
  let provider = new ethers.JsonRpcProvider("HTTP://127.0.0.1:7545");
  let wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("Deploying, please wait...");
  const contract = await contractFactory.deploy();
  console.log(contract);
  let currentFavoriteNumber = await contract.retrieve();
  console.log(currentFavoriteNumber.toString());
  const transactionResponse = await contract.store("7");
  const updatedNum = await contract.retrieve();
  console.log(updatedNum.toString());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
