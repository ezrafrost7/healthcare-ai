exports.handler = async (event) => {
    // Extract the input text from the request
    const inputText = event.body;

    // Your logic goes here
    const responseText = 'Thank you for contacting us';

    // Return a response
    const response = {
        statusCode: 200,
        body: responseText,
    };
    return response;
};