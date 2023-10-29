document.addEventListener("DOMContentLoaded", () =>{
    M.Modal.init(document.querySelectorAll('.modal'),{
        opacity: 0.5,
        inDuration: 200,
        outDuration: 200,
        onOpenStart:onOpenOpens,
    });
    const authSignInButton = document.getElementById("auth-sign-in");
    if (authSignInButton){
        authSignInButton.addEventListener("click", authSignInButtonClick)
    }
    else{
        console.log("#auth-sign-in not found");
    }
    const spaTokenStatus = document.getElementById("spa-token-status");
    if( spaTokenStatus ) {
        const token = window.localStorage.getItem('token');
        if( token ) {
            const tokenObject = JSON.parse( atob( token ) ) ;
            // TODO: перевірити на правильність декодування та дійсність
            spaTokenStatus.innerText = "Дійсний до " + tokenObject.exp ;
            const appContext = getAppContext();
            fetch(`${appContext}/tpl/spa-auth.html`, {
                method: 'GET',
                headers:{
                    "Authorization": `Bearer ${token}`
                }
            })
                .then(r=>r.text())
                .then( t =>
                    document.querySelector('auth-part').innerHTML = t ) ;

            document.getElementById("spa-log-out")
                .addEventListener('click', logoutClick ) ;
        }
        else {
            spaTokenStatus.innerText = 'Не встановлено';
        }
    }
    const spaGetDataButton = document.getElementById("spa-get-data");
    if (spaGetDataButton) spaGetDataButton.addEventListener('click', spaGetDataClick);
});

function spaGetDataClick() {
    console.log('spaGetDataClick');
    fetch(`${getAppContext()}/tpl/NP.png`, {
        method: 'GET',
        headers: {
            "Authorization": `Bearer ${window.localStorage.getItem('token')}`
        }
    }).then(r => r.blob())
        .then(b => {
            const blobUrl = URL.createObjectURL(b);
            document.querySelector('auth-part').innerHTML +=
                `<img src="${blobUrl}" width="100"/>`;
        });
}
function logoutClick(){
    window.localStorage.removeItem('jti');
    window.location.reload();
}
function onOpenOpens(){
    [authLogin, authPassword, authMessage] = getAuthElements();
    authLogin.value = "";
    authPassword.value = "";
    authMessage.innerText = "";
}

function getAuthElements(){
    const authLogin = document.getElementById("auth-login");
    if (! authLogin){
        throw "#auth-sign-in not found";
    }
    const authPassword = document.getElementById("auth-password");
    if (! authPassword){
        throw "#auth-password not found";
    }
    const authMessage = document.getElementById("auth-message");
    if (! authMessage){
        throw "auth-message not found";
    }
    return [authLogin, authPassword, authMessage];
}
function getAppContext(){
    return '/' + window.location.pathname.split('/')[1];
}
function authSignInButtonClick(){
    [authLogin, authPassword, authMessage] = getAuthElements();
    if (authLogin.value.length === 0){
        authMessage.innerText = "Login can't be empty";
    }
    const appContext = getAppContext();
    fetch(`${appContext}/auth?login=${authLogin.value}&password=${authPassword.value}`, {
        method: 'GET'
    }).then(r => {
        if(r.status !== 200){
            authMessage.innerText = "Unauthorized";
        }else{
            r.text().then(base64encoderText =>{
                console.log(base64encoderText);
                // base64 decoding
                const token = JSON.parse(atob(base64encoderText));
                if(typeof  token.jti === 'undefined'){
                    authMessage.innerText = "Get token error";
                    return;
                }
                window.localStorage.setItem('token', base64encoderText);
                window.location.reload();
            });
        }
    });
}