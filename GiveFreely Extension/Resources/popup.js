const backgroundColorPicker = document.getElementById('backgroundColorPicker');
const resetBGButton = document.getElementById('resetBGButton');

backgroundColorPicker.addEventListener('input', function() {
    const newColor = backgroundColorPicker.value;
    
    const messageArgument = {
        message: {
            action: "changeColor",
            color: newColor
        }
    };
    
    browser.runtime.sendNativeMessage("application.id", messageArgument, function(response) {
        console.log(response);
        if(response.status === "success") {
            browser.runtime.sendMessage({ messageArgument }).then((response) => {
                console.log("Received response: ", response);
            });
        }
    });
});

const textSizeSlider = document.getElementById('textSizeSlider');
const fontSizeSpan = document.getElementById('fontSize');
const resetButton = document.getElementById('resetButton');

textSizeSlider.addEventListener('input', function() {
    const newSize = textSizeSlider.value;
    fontSizeSpan.textContent = newSize;
    
    const messageArgument = {
        message: {
            action: "changeFontSize",
            size: newSize
        }
    };
    
    console.log(messageArgument)
    
    browser.runtime.sendNativeMessage("application.id", messageArgument, function(response) {
        console.log(response);
        if(response.status === "success") {
            browser.runtime.sendMessage({ messageArgument }).then((response) => {
                console.log("Received response: ", response);
            });
        }
    });
});

const keywordInput = document.getElementById('keywordInput');
const highlightButton = document.getElementById('highlightButton');

highlightButton.addEventListener('click', function() {
    const word = keywordInput.value;
    const messageArgument = {
        message: {
            action: "highlightWord",
        keyword: word
        }
    };
    
    browser.runtime.sendNativeMessage("application.id", messageArgument, function(response) {
        console.log(response);
        if(response.status === "success") {
            browser.runtime.sendMessage({ messageArgument }).then((response) => {
                console.log("Received response: ", response);
            });
        }
    });
});
