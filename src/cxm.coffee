request = require 'request-promise'
Promise = require 'bluebird'
_ = require 'lodash'
urlParser = require 'url'

class Cxm
    constructor: (options) ->
        defaultOptions =
            url: ''
            key: ''
        {@url, @key} = _.extend defaultOptions, options

    # makes an HTTPS request to a give API endpoint path
    # path is relative to the API URL, and can contain
    # query parameters but doesn't need to have the API key
    makeRequest: (path) =>
        url = "#{@url}/#{path.replace /^\/+/, ''}"
        # parse URL, so we can add 'key' parameter
        urlBits = urlParser.parse url, true
        urlBits.query.key = @key
        url = urlParser.format urlBits

        options =
            url: url
            json: true
            agentOptions:
                rejectUnauthorized: false #temporary

        request.get options

        .catch (response) ->
            message = "CXM API returned HTTP error #{response.statusCode}"
            if response.error
                error = JSON.parse response.error
                message += ": #{error.message}" if error.message
            return Promise.reject message: message, errorCode: response.statusCode

    case: (ref) =>
        @makeRequest "case/#{ref}"

module.exports = Cxm
