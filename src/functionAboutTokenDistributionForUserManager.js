



// ======================================================================
// from tokenDistributionForUserManager smartContract

function insertUser_distributionForUserManager(userAddress) {
    return new Promise((resolve, reject) => {
        tokenDistributionForUserManager.insertUser(userAddress, (error, response) => {
            if(!error) {
                console.log("insertUser_distributionForUserManager("+[userAddress].join()+")_success:")
                // console.log(distributionForThisUserThisToken);
                resolve(response);
            } else {
                console.log("insertUser_distributionForUserManager("+[userAddress].join()+")_error:")
                reject(error);
            }
        });
    });
}

function insertTokenForUser_distributionForUserManager(userAddress, filmIndex, numberToken_thisUser) {
    return new Promise((resolve, reject) => {
        tokenDistributionForUserManager.insertTokenForUser(userAddress, filmIndex, "0", "0", numberToken_thisUser, (error, response) => {
            if(!error) {
                console.log("insertTokenForUser_distributionForUserManager("+[filmIndex, userAddress, numberToken_thisUser].join()+")_success:")
                // console.log(distributionForThisUserThisToken);
                resolve(response);
            } else {
                console.log("insertTokenForUser_distributionForUserManager("+[filmIndex, userAddress, numberToken_thisUser].join()+")_error:")
                reject(error);
            }
        });
    });
}



function getAllTokenForOneUser(userAddress) {
	return new Promise((resolve, reject) => {
		tokenDistributionForUserManager.getAllTokenForOneUser(userAddress, (error, response) => {
			if(!error) {
				console.log("getAllTokenForOneUser("+userAddress+")_success:");
				var userBoughtTokens = [];
				for(var item in response) {
					userBoughtTokens.push(response[item].c[0]);
				}
				// console.log(userBoughtTokens);
				resolve(userBoughtTokens);
			} else {
				console.log("getAllTokenForOneUser("+userAddress+")_error:");
				reject(error);
			}
		});
	});
}

function getTokenForUser(userAddress, filmIndex) {
	return new Promise((resolve, reject) => {
		tokenDistributionForUserManager.getTokenForUser(userAddress, filmIndex, (error, response) => {
			if(!error) {
				console.log("getTokenForUser("+[userAddress, filmIndex].join()+")_success:");
				var distributionForThisUser = {
					"userAddress": userAddress, 
					"filmIndex": filmIndex, 
					"index_userBoutTokens": response[0].c[0], 
					// "numberTokenPocket": response[2].c[0], 
					// "numberTokenOnSell": response[3].c[0], 
					"numberToken_user": response[4].c[0], 
				};
				// console.log(distributionForThisUser);
				resolve(distributionForThisUser);
			} else {
				console.log("getTokenForUser("+[userAddress, filmIndex].join()+")_error:");
				reject(error);
			}
		});
	});
}

function updateTokenForUser(userAddress, filmIndex, numberTokenPocket, numberTokenOnSell, numberTokenTotal) {
	return new Promise((resolve, reject) => {
		tokenDistributionForUserManager.updateTokenForUser(userAddress, filmIndex, numberTokenPocket, numberTokenOnSell, numberTokenTotal, (error, response) => {
			if(!error) {
				console.log("updateTokenForUser("+[userAddress, filmIndex, numberTokenPocket, numberTokenOnSell, numberTokenTotal].join()+")_success:");
				
				// console.log(response);
				resolve(response);
			} else {
				console.log("updateTokenForUser("+[userAddress, filmIndex, numberTokenPocket, numberTokenOnSell, numberTokenTotal].join()+")_error:");
				reject(error);
			}
		});
	});
}


function deleteToken_DistributionForUserManager(userAddress, filmIndex) {
	return new Promise((resolve, reject) => {
		tokenDistributionForUserManager.deleteTokenForUser(userAddress, filmIndex, (error, response) => {
			if(!error) {
				console.log("deleteToken_DistributionForUserManager("+[userAddress, filmIndex].join()+")_success:");
				
				// console.log(response);
				resolve(response);
			} else {
				console.log("deleteToken_DistributionForUserManager("+[userAddress, filmIndex].join()+")_error:");
				reject(error);
			}
		});
	});
}