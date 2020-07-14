//my.js
function addEvent(obj,ev,fn){
	if(obj.addEventListener){
		//ff:addEventListener
		obj.addEventListener(ev,fn,false);
	}else{
		//IE:attachEvent
		obj.attachEvent('on'+ev,fn);
	}
}


//触发一个事件
function trigger(element,eventName="change"){
	if( document.createEvent ){
		var evObj = document.createEvent('HTMLEvents');
		evObj.initEvent( eventName, false, true);
		element.dispatchEvent(evObj);//chrome
	}else if( document.createEventObject ){
		element.fireEvent('on'+eventName);//IE
	}
}


/* 示例 */
addEvent(window,'load',function(){
	var $2=function(o){return document.getElementById(o);}

	//提交按钮点击
	$2('submit').onclick=function(){
		// alert('you clicked me!')
		var text=$2('genes').value;
		var arr=text.split(/[^0-9a-zA-Z\-]+/g)
		console.log(arr.length)
	}


	//demo
	$2('use_demo').onclick=function(){
		var text_box=$2('genes');
		var glist="ASF1B ATAD2 BLM BRCA1"
		text_box.value=glist;

		// 要主动触发输入框的改变事件
		trigger(text_box,'change')
	}

})