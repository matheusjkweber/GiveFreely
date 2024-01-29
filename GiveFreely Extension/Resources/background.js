browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);
    sendMessageToContent(request)
    sendResponse("Request done.")
});

function sendMessageToContent(message) {
    const isChrome = !window["browser"] && !!chrome;
    const browser = isChrome ? chrome : window["browser"];
    
    browser.tabs.query({ active: true }).then(function (currentTabs) {
        if (currentTabs[0].id >= 0) {
            browser.tabs.sendMessage(currentTabs[0].id, message);
        }
    });
}
