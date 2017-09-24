/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,Dimensions,
  Text,TouchableOpacity,
  View
} from 'react-native';
const {width, height} = Dimensions.get('window');
import RNTweet from 'react-native-tweet';
const CONSUMER_KEY = "s16Ma7vAyMTotQYaHQ40YLAbi"
const CONSUMER_SECRET = "EaaAJg75eO7H0gfEHbSvW0WjzMvtMFgbsuTVBU2PbM8QZVav3I"
RNTweet.init({consumerKey:CONSUMER_KEY,consumerSecret:CONSUMER_SECRET})

export default class Example extends Component {
  constructor(props){
  	super(props);
  	this.state = {
      user:null,
      tweets:[],
    };


    this.compose=this.compose.bind(this)
    this.login=this.login.bind(this)
    this.logout=this.logout.bind(this)
    this.api=this.api.bind(this)
    this.getUser=this.getUser.bind(this)
    this.retweet=this.retweet.bind(this)
  }



  login(){
    RNTweet.login().then(user=>{
console.log(" login: ",user);
      this.setState({user})})
    .catch((e)=>{console.warn("e",e)})
  }
  compose(){
    RNTwitter.compose({
    setText:"React Native Tweet is Lit 🔥!",
    setURL:"https://github.com/garrettmac/react-native-tweet"
    // setVideo:"YOUR VIDEO",//coming soon
    // setImage:"https://unsplash.it/900/900/?random",
  }).then(success=>{
    console.log(" compose: ",success);
    //code
  }).catch((e)=>{console.warn("e",e)})
  }
  api(q="#Trump",count=5){
    RNTweet.api({
        endpoint: 'search/tweets.json',
        q: encodeURI(`${q}`),
        count
      }).then(apiData=>{
        console.log(" api: ",apiData);
        if(apiData&&apiData.statuses)this.setState({tweets:apiData.statuses})
      })
    .catch((e)=>{console.warn("e",e)})
  }

  logout(){
    RNTweet.logout().then(success=>{
      console.log(" success: ",success);
      this.setState({user:null})
    })
    .catch((e)=>{console.warn("e",e)})
  }
  getUser(){
    RNTweet.getUser().then(user=>{
      console.log(" getUser: ",user);
      this.setState({user})
    })
    .catch((e)=>{console.warn("e",e)})
  }
  retweet(tweetId=""){

    RNTweet.retweet(tweetId).then(user=>{
      console.log(" retweet: ",user);
      this.setState({user})
    })
  }

  render() {
    return (
      <View style={s.container}>
        <Text style={s.welcome}>
          Welcome to React Native Tweet!
        </Text>
        <Text style={s.instructions}>
User Details
        </Text>
        <Text style={s.instructions}>
          {JSON.stringify(this.state.user)}
        </Text>

<View style={[s.rowContainer,s.spaceAround,s.margin10]}>




          {!this.state.user && (
            <TouchableOpacity onPress={this.login} style={[s.rowItem,s.centerItem]}>
              <Text style={[s.textStyle]}>Login</Text>
            </TouchableOpacity>)
          }
          {this.state.user && (
            <TouchableOpacity onPress={this.logout} style={[s.rowItem,s.centerItem]}>
              <Text style={[s.textStyle]}>Log Out</Text>
            </TouchableOpacity>)
          }

          </View>
          <View style={[s.rowContainer,s.spaceAround,s.margin10]}>




          <TouchableOpacity onPress={this.api} style={[s.rowItem,s.centerItem]}>
            <Text style={[s.textStyle]}>Search API for "Trump"</Text>
          </TouchableOpacity>

          <TouchableOpacity onPress={this.compose} style={[s.rowItem,s.centerItem]}>
            <Text style={[s.textStyle]}>Compose Tweet</Text>
          </TouchableOpacity>
        </View>
        <View style={[s.rowContainer,s.spaceAround,s.margin10]}>



          <TouchableOpacity onPress={this.getUser} style={[s.rowItem,s.centerItem]}>
            <Text style={[s.textStyle]}>Get User</Text>
          </TouchableOpacity>
</View>


          {this.state.tweets && (
            <View style={[s.viewStyle]}>
              {this.state.tweets.map((item,i) => {
                return   <Text key={`tweet-{i}`} style={[s.textStyle]}>{JSON.stringify(item)}</Text>
              })}
            </View>)}





      </View>
    );
  }
}
let BUTTON_ROW_NUM_OF_BUTTONS=2
let BUTTON_ROW_HEIGHT=50
let BUTTON_HEIGHT=50


const s = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  border: {borderWidth:1,borderColor:"red",borderRadius:5,},
  centerItem:{justifyContent:"center",alignItems:"center",},
  margin10:{margin:10,},
  rowContainer:{flexDirection: 'row',height:BUTTON_ROW_HEIGHT,},
  spaceAround:{justifyContent: 'space-around',alignItems: 'center',},
  spaceBetween:{justifyContent: 'space-between',alignItems: 'center',},
  rowItem:{backgroundColor: "transparent",width:width/BUTTON_ROW_NUM_OF_BUTTONS-20,height: BUTTON_HEIGHT, borderRadius:5,},
  rowItemBorder:{borderWidth:0.8,borderColor:"rgba(0,0,0,0.1)"},
  textStyle:{color:"rgba(0,0,0,0.5)", textAlignVertical: "center", textAlign: "center",},
viewStyle:{flex: 1},
textStyle:{color:"rgba(0,0,0,0.5)", textAlignVertical: "center", textAlign: "center",},

  viewShadow:{shadowOpacity: 1,shadowOffset: {width: 0,height: 5},shadowRadius: 4,shadowColor:"rgba(0,0,0,0.6)",},

});

AppRegistry.registerComponent('Example', () => Example);
