request = require 'request-promise'
Promise = require 'bluebird'
_ = require 'lodash'

class Cxm
    constructor: (options) ->
        defaultOptions =
            url: ''
            key: ''
        {@url, @key} = _.extend defaultOptions, options

    makeRequest: (url) =>
        options =
            url: url
            agentOptions:
                rejectUnauthorized: false #temporary

        request.get options

    case: (ref) =>
        @makeRequest "#{@url}/case/#{ref}?key=#{@key}"
        .then (body, response) ->
            JSON.parse body
        .catch (err) -> null

module.exports = Cxm
