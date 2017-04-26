# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

contractAddress = '0x36c763da246c80b8196c828d416308de64fa823b'
abi = [{"constant":false,"inputs":[{"name":"x","type":"uint256"}],"name":"set","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"get","outputs":[{"name":"storageValue","type":"uint256"}],"payable":false,"type":"function"}]
isActive = true



window.addEventListener 'load', ->

#  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 != 'undefined')
    #    // Use Mist/MetaMask's provider
    window.web3 = new Web3(web3.currentProvider)
  else
    console.log('No web3? You should consider trying MetaMask!')
    #// fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    #//window.web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
    window.web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/XTrNmygmqG6zMCZen6TJ"))
 # // Now you can start your app & access web3 freely:
  startApp()
  pollServer()

  $("body").on "click", ".toggle-price", ->
    if isActive
      $(".toggle-price").text "OFF"
      $(".price-on").addClass "none"
      $(".toggle-price").removeClass "badge-primary"
      $(".toggle-price").addClass "badge-danger"
      isActive = false
    else
      $(".toggle-price").text "ON"
      $(".price-on").removeClass "none"
      $(".toggle-price").removeClass "badge-danger"
      $(".toggle-price").addClass "badge-primary"
      isActive = true
      pollServer()




startApp = ->
  simpleDappContract = web3.eth.contract(abi)
  simpleDapp = simpleDappContract.at(contractAddress)
#  document.getElementById('contractAddr').innerHTML = getLink(contractAddress);
  web3.eth.getAccounts (e,r) ->
    console.log('Account' + r[0])
    $(".current-account").text r[0]
pollServer = ->
  if isActive
    window.setTimeout (->
      $.ajax
        url: "/api/get_ticker.json?type=coinone"
        type: "GET",
        success: (result) ->
           $(".coinone-price").text result["data"]["last"]
           pollServer()
        error: ->
          $(".coinone-price").text 'error'
          pollServer()
    ), 1500



window.contractAddress = contractAddress
window.abi = abi
window.startApp = startApp
