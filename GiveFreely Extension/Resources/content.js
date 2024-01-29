browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received requesaaaat: ", request);
    console.log(request.messageArgument)
    console.log(request.messageArgument.message)
    console.log(request.messageArgument.message.action)
    if(request.messageArgument.message.action === "changeColor") {
        document.body.style.backgroundColor = request.messageArgument.message.color;
    } else if(request.messageArgument.message.action === "changeFontSize") {
        document.body.style.fontSize = request.messageArgument.message.size + 'px';
    } else if(request.messageArgument.message.action === "highlightWord") {
        console.log(request.messageArgument.message.keyword)
        highlightWord(request.messageArgument.message.keyword)
    }
})

function highlightWord(word) {
    const regex = new RegExp(word, 'gi');

    function highlightTextNodes(node) {
        if (node.nodeType === Node.TEXT_NODE) {
            const matches = node.nodeValue.match(regex);
            if (matches) {
                const fragment = document.createDocumentFragment();

                matches.forEach(match => {
                    const span = document.createElement('span');
                    span.style.textColor = 'black';
                    span.style.backgroundColor = 'yellow'; // Set the highlight color
                    span.appendChild(document.createTextNode(match));
                    fragment.appendChild(span);
                });

                node.replaceWith(fragment);
            }
        } else if (node.nodeType === Node.ELEMENT_NODE) {
            node.childNodes.forEach(highlightTextNodes);
        }
    }

    highlightTextNodes(document.body);
}
