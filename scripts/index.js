exports.handler = async (event) => {
    // Extract the input text from the request
    const inputText = event.body;

    // Your logic goes here

    // Return a response
    const response = {
        statusCode: 200,
        body: "Success",
    };
    return response;
};