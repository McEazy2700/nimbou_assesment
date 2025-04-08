# Decentralized Barter System

This application is a decentralized barter system that allows users to list goods or services, earn "Barter Coins" (BC), and use those coins to trade.

## Setup and Run Locally

### Prerequisites

* Node.js and npm (or yarn) installed
* Ganache CLI or Ganache GUI installed
* MetaMask browser extension installed

### Installation

1.  **Clone the repository:**

    ```bash
    git clone <your_repository_url>
    cd <your_repository_directory>
    ```

2.  **Backend Setup (AdonisJS):**

    ```bash
    cd barter-backend
    npm install
    npm run build
    node ace configure @adonisjs/lucid
    # Choose sqlite and default file path
    node ace migration:run
    node ace configure @adonisjs/auth
    # Choose api guard and lucid provider
    node ace configure @adonisjs/jwt
    ```

3.  **Smart Contract Deployment:**

    * Start Ganache.
    * Compile and deploy the `BarterCoin.sol` and `BarterMarket.sol` contracts using Remix, Hardhat, or Truffle.
    * Note down the deployed contract addresses.

4.  **Environment Configuration:**

    * In the `barter-backend` directory, create a `.env` file and populate it with your database and smart contract details:

        ```
        PORT=3333
        HOST=localhost
        NODE_ENV=development
        APP_KEY=<your_app_key> # Generate using 'node ace generate:key'
        DB_CONNECTION=sqlite
        DB_FILE=database.sqlite3
        BARTER_COIN_CONTRACT_ADDRESS=<BarterCoin_contract_address>
        BARTER_MARKET_CONTRACT_ADDRESS=<BarterMarket_contract_address>
        ```

5.  **Run the Backend:**

    ```bash
    cd barter-backend
    node build/server.js
    ```

6.  **Frontend Setup (React):**

    * (Instructions for setting up the React frontend would go here. Please provide the specific instructions for your frontend setup.)

7.  **Run the Frontend:**

    * (Instructions for running the React frontend would go here.)

### Application Architecture

The application follows a layered architecture:

1.  **Smart Contracts (Solidity):**
    * `BarterCoin.sol`: Manages the Barter Coin token, including minting and transfers.
    * `BarterMarket.sol`: Handles the listing and purchasing of items using Barter Coins.

2.  **Backend (AdonisJS):**
    * Provides API endpoints for user authentication, item retrieval, and balance checking.
    * Interacts with the smart contracts using Ethers.js or Web3.js.
    * Manages user data and stores it in a database.

3.  **Frontend (React):**
    * Provides the user interface for interacting with the barter system.
    * Allows users to register, log in, list items, view items, and purchase items.
    * Connects to the blockchain using MetaMask to facilitate transactions.

**Barter Coin Flow:**

* Users earn Barter Coins through trading activities within the system (e.g., listing items, providing services).
* When a user lists an item, the details are stored in the `BarterMarket` smart contract.
* When a user buys an item:
    * The buyer's Barter Coin balance is decreased by the item's price.
    * The seller's Barter Coin balance is increased by the item's price.
    * These transactions are recorded on the blockchain, ensuring transparency and immutability.

### Written Answers

1.  **How does the smart contract ensure secure transactions for Barter Coins?**

    The smart contract ensures secure transactions through the following mechanisms:

    * **Immutability:** Once deployed, the contract's code cannot be changed, preventing tampering with the transaction logic.
    * **Transparency:** All transactions are recorded on the blockchain and are publicly visible, providing an audit trail.
    * **Access Control:** The contract enforces rules such as checking for sufficient balance before transferring coins and ensuring only the item owner can list it.
    * **Cryptographic Security:** Blockchain technology uses cryptography to secure transactions and prevent double-spending.

2.  **Why did you use AdonisJS in this application, and what does it handle?**

    AdonisJS was used for the backend due to its:

    * **MVC Architecture:** Provides a structured way to organize the backend logic.
    * **TypeScript Support:** Enables type safety and improves code maintainability.
    * **ORM (Lucid):** Simplifies database interactions.
    * **Authentication and Security:** Offers built-in packages for handling user authentication and security.
    * **API Development:** Facilitates the creation of RESTful APIs.

    AdonisJS handles:

    * User authentication and management.
    * API endpoints for frontend interaction.
    * Database operations.
    * Interaction with the smart contracts (reading data and triggering transactions).

3.  **What challenges did you face, and how did you overcome them?**

    (Please provide your specific challenges and how you addressed them. Some general examples include:)

    * **Smart Contract Development:**
        * Challenge: Understanding Solidity syntax and best practices.
        * Solution: Referencing Solidity documentation and online tutorials.
    * **Blockchain Integration:**
        * Challenge: Interacting with the blockchain using Ethers.js/Web3.js.
        * Solution: Consulting the library documentation and examples.
    * **State Management:**
        * Challenge: Managing the application state between the frontend and the blockchain.
        * Solution: Implementing appropriate state management techniques in React (e.g., Context API, Redux).
    * **Asynchronous Operations:**
        * Challenge: Handling asynchronous operations when interacting with the blockchain.
        * Solution: Using Promises and async/await to manage asynchronous code.
    * **AdonisJS Configuration:**
        * Challenge: Setting up AdonisJS correctly, especially with TypeScript and `@ioc`.
        * Solution: Carefully following the AdonisJS documentation and seeking help from online communities.
