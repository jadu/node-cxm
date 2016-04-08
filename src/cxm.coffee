https = require 'https'
Promise = require 'bluebird'
_ = require 'lodash'

class Cxm
    constructor: (options) ->
        defaultOptions =
            url: ''
            key: ''
        {@url, @key} = _.extend defaultOptions, options

    makeRequest: (url) =>
        new Promise (resolve, reject) =>
            request = https.get url, (response) =>
                body = ''
                response.on 'data', (chunk) ->
                  body += chunk
                response.on 'end', =>
                    if response[content-type] is 'application/json'
                        body = JSON.parse body
                    resolve body, response
            request.end()

    case: (ref) =>
        new Promise (resolve, reject) =>
            url = "#{@url}/case/#{ref}?key"
            @makeRequest.then (body, response) ->
                resolve body

module.exports = Cxm
