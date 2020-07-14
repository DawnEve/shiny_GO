//tags$script(src='my.js')

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

		$2('geneNumber').innerHTML=arr.length;
	}

	//输入框: 单击时全选
	$2('genes').onclick=function(){
		this.select()
	}

	//demo按钮 单击时填充示例
	$2('use_demo').onclick=function(){
		var text_box=$2('genes')
		var glist="ASF1B ATAD2 BLM BRCA1 CALD1 CALM2 CCDC14 CCDC84 CDCA5 CENPM CHML DCAF16 DHFR DNAJB4 DONSON DSCC1 DYNC1LI2 EIF4EBP2 ENOSF1 ESCO2 EXO1 EZH2 FANCI GCLM HELLS HIST1H4C MAP3K2 MASTL MCM8 MYCBP2 NEAT1 NFE2L2 NSUN3 NT5DC1 OGT ORC3 PHIP PHTF2 PKMYT1 POLA1 PRIM1 PTAR1 RAD18 RBBP8 RFC2 RRM1 RRM2 RSRC2 SAP30BP SLC38A2 SRSF5 SVIP TOP2A TYMS UBE2T USP1 ZWINT"
		// $2('genes').value=glist;
		text_box.innerHTML=glist
		// 要主动触发输入框的改变事件
		trigger(text_box,'change')
	}

});