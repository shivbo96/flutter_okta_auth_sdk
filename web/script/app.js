// app.js
function loginOkta(configJson) {
  try {
    console.log("Received config:", configJson);
    // Parse the JSON string sent from Dart
    const config = JSON.parse(configJson);
    console.log("Parsed config:", config);

    const authClient = new OktaAuth({
      clientId: config.clientId,
      redirectUri: config.redirectUri,
      state: `state-${uuid()}`,
      responseType: 'code',
      scopes: ['openid', 'email', 'profile'],
      codeChallengeMethod: 'S256',
      codeChallenge: config.codeChallenge,
      issuer: config.issuer
    });

    // Initiate redirect for authorization code flow
    authClient.signInWithRedirect({
      scopes: ['openid', 'email', 'profile']
    });
  } catch (error) {
    console.error("Error in loginOkta:", error);
    alert("Login failed: " + error.message);
  }
}

function loginTokenOkta(configJson) {
  try {
    const config = JSON.parse(configJson);
    const authClient = new OktaAuth({
      clientId: config.clientId,
      redirectUri: config.redirectUri,
      issuer: config.issuer
    });

    authClient.token.parseFromUrl()
      .then(data => {
        console.log("Tokens:", data.tokens);
        const { accessToken, idToken } = data.tokens;
        // Send access token to Flutter via postMessage
        window.parent.postMessage(accessToken?.value, "*");
        if (idToken) {
          authClient.tokenManager.setTokens({ idToken });
        }
      })
      .catch(error => {
        console.error("Error parsing token:", error);
        alert("Token exchange failed: " + error.message);
      });
  } catch (error) {
    console.error("Error in loginTokenOkta:", error);
    alert("Error: " + error.message);
  }
}

function logout(configJson) {
  try {
    const config = JSON.parse(configJson);
    const authClient = new OktaAuth({
      redirectUri: config.endSessionRedirectUri,
      issuer: config.issuer
    });
    authClient.signOut();
  } catch (error) {
    console.error("Error in logout:", error);
    alert("Logout failed: " + error.message);
  }
}

function uuid() {
  return ([1e7] + -1e3 + -4e3 + -8e3 + -1e11).replace(/[018]/g, c =>
    (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
  );
}


  // define this before your Flutter bootstraps!
  function alertMessage(msg) {
    window.alert("From JS: " + msg);
  }
