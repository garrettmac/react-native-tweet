/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,TouchableOpacity,
  View
} from 'react-native';
const ConsumerKey = "s16Ma7vAyMTotQYaHQ40YLAbi"
const consumerSecret = "EaaAJg75eO7H0gfEHbSvW0WjzMvtMFgbsuTVBU2PbM8QZVav3I"
export default class Example extends Component {
  constructor(props){
  	super(props);
  	this.state = {};
    this.renderButtonRow=this.renderButtonRow.bind(this)
    this.onPressTouchable=this.onPressTouchable.bind(this)
  }
  onPressTouchable(){

  }


  renderButtonRow(){
    return (<View style={[s.rowContainer,s.spaceAround,s.margin10,s.border]}>
      <TouchableOpacity onPress={this.onPressTouchable} style={[s.rowItem,s.centerItem]}>
<Text style={[s.textStyle]}>hi</Text>
      </TouchableOpacity>

        <TouchableOpacity onPress={this.onPressTouchable} style={[s.rowItem,s.centerItem]}>
          <Text style={[s.textStyle]}>ho</Text>
        </TouchableOpacity>
    </View>)
  }
  render() {
    return (
      <View style={s.container}>
        <Text style={s.welcome}>
          Welcome to React Native Tweet!
        </Text>
        <Text style={s.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={s.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>



          {this.renderButtonRow()}



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

  viewShadow:{shadowOpacity: 1,shadowOffset: {width: 0,height: 5},shadowRadius: 4,shadowColor:"rgba(0,0,0,0.6)",},

});

AppRegistry.registerComponent('Example', () => Example);
