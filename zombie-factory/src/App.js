import React, {useEffect, useState} from 'react';
import Web3 from 'web3';
import './App.css';

const App = () => {
  const [ isLoading, setIsLoading ] = useState(false);
  const [ currentAccount, setCurrentAccount] = useState(null);

  const checkIfWalletIsConnected = async () => {
		try {
			const { ethereum } = window;

			if (!ethereum) {
				console.log('Make sure you have MetaMask!');
				setIsLoading(false);
				return;
			} else {
				console.log('We have the ethereum object', ethereum);
        
        let chainId = await ethereum.request({ method: 'eth_chainId' });
        console.log("Connected to chain " + chainId);
    
        // String, hex code of the chainId of the Rinkebey test network
        const rinkebyChainId = "0x4"; 
        if (chainId !== rinkebyChainId) {
          alert("You are not connected to the Rinkeby Test Network!");
          return;
        }

				const accounts = await ethereum.request({ method: 'eth_accounts' });

				/*
          * User can have multiple authorized accounts, we grab the first one if its there!
          */
				if (accounts.length !== 0) {
					const account = accounts[0];
					console.log('Found an authorized account:', account);
					setCurrentAccount(account);
				} else {
					console.log('No authorized account found');
				}
			}
		} catch (error) {
			console.log(error);
		}
	};

	const connectWalletAction = async () => {
		try {
			const { ethereum } = window;

			if (!ethereum) {
				alert('Get MetaMask!');
				return;
			}
      

			const accounts = await ethereum.request({
				method: 'eth_requestAccounts'
			});
			console.log('Connected', accounts[0]);
			setCurrentAccount(accounts[0]);
		} catch (error) {
			console.log(error);
		}
	};
  
  useEffect(() => {
    const web3 = new Web3(new Web3.providers.WebsocketProvider("wss://mainnet.infura.io/ws"));
  })

  return (
    <div className="App">
      <h1>hello</h1>
    </div>
  );
}

export default App;
