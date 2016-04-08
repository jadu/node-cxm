sinon = require 'sinon'
chai = require 'chai'
sinonChai = require 'sinon-chai'
chaiAsPromised = require 'chai-as-promised'
chai.should()
chai.use sinonChai
chai.use chaiAsPromised

Cxm = require '../src/cxm'

cxm = null

describe 'cxm', ->

    describe 'constructor', ->
        it "sets instance properties from options passed", ->
            cxm = new Cxm url: 'https://foo', key: 'e-minor'
            cxm.url.should.equal 'https://foo'
            cxm.key.should.equal 'e-minor'
