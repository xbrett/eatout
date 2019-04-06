// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
import socket from "./socket"

let channelChatId = window.channelChatId;
console.log(channelChatId)

if (channelChatId) {
	let receiver_id = window.receiver_id;
	let sender_id = window.sender_id;
	let channel = socket.channel(`chats:${channelChatId}`, {}); // connect to chat "room"
	channel.on(`chat:${channelChatId}:new_msg`, function (payload) { // listen to the new message event in appr chatroom
		let li = document.createElement("li", {class : "list-group-item"}); // creaet new list item DOM element
		let name = payload.name;    								 // get name from payload 
		li.innerHTML = "<b>" + name + "</b>: " + payload.message; // set li contents
		ul.appendChild(li);                   				   // append to list
	});

	channel.join()
	  .receive("ok", resp => { console.log("Joined successfully", resp) })
	  .receive("error", resp => { console.log("Unable to join", resp) })

	let ul = document.getElementById("msg-list");        // list of messages.
	let name = document.getElementById("name");         // name of message sender
	let msg = document.getElementById("msg");          // element storing message

	msg.addEventListener("keypress", function (ev) {
		if (ev.keyCode == 13 && msg.value.length > 0) { // enter pressed and message is not empty
	    	channel.push("shout", { 		// send the message to the server
	      		name: name.innerHTML,     // get name of sender
	      		message: msg.value,    	// get message of sender
	      		sender_id: sender_id,	// id of the sender
	      		receiver_id: receiver_id // id of the receiver
	    	});
	    	msg.value = "";         // reset the message input field.
	  	}
	});
}


import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";

window.onload = (ev) => {
  getLocation();
}

function createCookie(cookieName, cookieValue) {
  document.cookie = cookieName + "=" + cookieValue + ";";
}

function getLocation() {
  console.log(document.cookie);
  if (document.cookie.includes("long=") && document.cookie.includes("lat=")) {
    console.log("case1");
    return
  } else if (navigator.geolocation) {
    console.log("case2");
    navigator.geolocation.getCurrentPosition(showPosition);
  } else { 
    console.log("no geolocator");
    return null
  }
}

function showPosition(position) {
  createCookie("lat", "" + position.coords.latitude);
  createCookie("long", "" + position.coords.longitude);
  console.log(document.cookie);
  location.reload();
}
