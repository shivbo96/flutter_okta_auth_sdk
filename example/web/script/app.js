var state = `state-${uuid()}`;
function loginOkta(codeChallenge) {
var authClient = new OktaAuth({
  clientId: '',
 redirectUri: 'http://localhost:8080/login/callback',
  state: state,
  response_type: 'code',
  scope: ['openid', 'email', 'profile'],
  code_challenge_method: 'S256',
  code_challenge: codeChallenge,
  issuer: "https://localhost:8080/oauth2/default/"
});


authClient.token.getWithRedirect({
            responseType: ['idToken','token'],
             scopes: ['openid', 'email', 'profile']
          });
}

function loginTokenOkta(codeValue) {
var authClient = new OktaAuth({
  clientId: '',
 redirectUri: 'http://localhost:8080/login/callback',
  grant_type: 'authorization_code',
  token_endpoint_auth_method : 'none',
//  code_challenge: codeChallenge,
  code:codeValue,
  issuer: "https://localhost:8080/oauth2/default/"
});
authClient.token.parseFromUrl()
    .then(data => {
      window.parent.postMessage(data.tokens.accessToken.value, "*");
      const { idToken } = data.tokens;
      authClient.tokenManager.add('accessToken', idToken);
    });
}

 function logout() {
 var authClient = new OktaAuth({
  redirectUri: 'http://localhost:8080/',
  issuer: "https://localhost:8080/oauth2/default"
 });
        authClient.signOut();
      }


function uuid() {
  return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c =>
    (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
  );
}

