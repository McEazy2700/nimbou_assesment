# Decentralized Barter System

This application is a decentralized barter system that allows users to list goods or services, earn "Barter Coins" (BC), and use those coins to trade.

## Setup and Run Locally

### Prerequisites

- Node.js and npm (or yarn) installed
- Ganache CLI or Ganache GUI installed
- MetaMask browser extension installed

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/McEazy2700/nimbou_assesment.git
    cd nimbou_assesment
    ```

2.  **Backend Setup (AdonisJS):**

    ```bash
    cd barter-backend
    docker compose up --build
    ```

3.  **Smart Contract Deployment:**

    - Start Ganache.
    - Compile and deploy the `BarterCoin.sol` and `BarterMarket.sol` contracts using Remix, Hardhat, or Truffle.
    - Note down the deployed contract addresses.

4.  **Frontend Setup (React):**

    - (Unimplemented)

### Application Architecture

The application follows a layered architecture:

1.  **Smart Contracts (Solidity):**

    - `BarterCoin.sol`: Manages the Barter Coin token, including minting and transfers.
    - `BarterMarket.sol`: Handles the listing and purchasing of items using Barter Coins.

2.  **Backend (AdonisJS):**

    - Provides API endpoints for user authentication, item retrieval, and balance checking.
    - Interacts with the smart contracts using Ethers.js or Web3.js.
    - Manages user data and stores it in a database.

3.  **Frontend (React):**
    - Provides the user interface for interacting with the barter system.
    - Allows users to register, log in, list items, view items, and purchase items.
    - Connects to the blockchain using MetaMask to facilitate transactions.

**Barter Coin Flow:**

- Admins can mint and transfer BarterCoins.
- When a user lists an item, the details are stored in the `BarterMarket` smart contract.
- When a user buys an item:
  - The buyer's Barter Coin balance is decreased by the item's price.
  - The seller's Barter Coin balance is increased by the item's price.
  - These transactions are recorded on the blockchain, ensuring transparency and immutability.

### Written Answers

1.  **How does the smart contract ensure secure transactions for Barter Coins?**

    The smart contract ensures secure transactions through the following mechanisms:

    - **Immutability:** Once deployed, the contract's code cannot be changed, preventing tampering with the transaction logic.
    - **Transparency:** All transactions are recorded on the blockchain and are publicly visible, providing an audit trail.
    - **Access Control:** The contract enforces rules such as checking for sufficient balance before transferring coins and ensuring only the item owner can list it.
    - **Cryptographic Security:** Blockchain technology uses cryptography to secure transactions and prevent double-spending.

2.  **Why did you use AdonisJS in this application, and what does it handle?**
    AdonisJS handles a lot of aspects of api development as listed bellow and provides good typescript support:

    - User authentication and management.
    - API endpoints for frontend interaction.
    - Database operations.
    - Interaction with the smart contracts (reading data and triggering transactions).

3.  **What challenges did you face, and how did you overcome them?**

    - **Framework Over-Engineering (Subjective):**

      - Challenge: AdonisJS, in my opinion, leans towards providing many built-in solutions (ORM, auth, etc.), which can feel like "over-engineering" for simpler API tasks. I personally prefer frameworks that focus primarily on request/response handling, allowing developers to choose and configure other components (database, auth) independently, the way AdonisJS is engineered requires having a lot of background knowledge / context before you can do even the most basic of things.
      - Solution: While I used AdonisJS as required, I had to adjust to its "batteries-included" approach. In future projects, I would likely opt for a more lightweight framework like Express.js to maintain finer-grained control.

    - **Solidity Familiarization:**

      - Challenge: Although Solidity simplifies smart contract development, my previous blockchain development experience has been primarily with Algorand, Stellar, and ICP. I had to dedicate time to learn Solidity syntax, best practices, and the nuances of the Ethereum Virtual Machine (EVM).
      - Solution: I utilized Solidity documentation, online tutorials, and examples to quickly get up to speed with the language and its ecosystem.
