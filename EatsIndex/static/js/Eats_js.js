//用来获取行间和内联或者外联的样式
function getStyle(obj, attr) {
	if (obj.currentStyle) {
		//用于IE
		return obj.currentStyle[attr];
	} else {
		//用于FF等浏览器,第一个参数是自身，第二个参数没用.
		return getComputedStyle(obj, null)[attr];
	}
}

function startMove(obj, attr, target) {
	clearInterval(obj.timer);
	var change = parseInt(getStyle(obj, attr));
	obj.timer = setInterval(function(){
		change = parseInt(getStyle(obj, attr));
		var speed = (target - change)/10;
		speed = speed>0? Math.ceil(speed):Math.floor(speed);
		if (change == target) {
			clearInterval(obj.timer);
		} else {
			obj.style[attr] = change + speed + 'px';
		}
	},30);
}

/*window.onload = function() {
	var linkarr = document.getElementsByClassName("naviContent");
	for(var i = 0; i < linkarr.length; i++) {
		linkarr[i].oriMarLeft = parseInt(getStyle(linkarr[i], 'margin-left'));
		linkarr[i].oriMarRight = parseInt(getStyle(linkarr[i], 'margin-right'));
		linkarr[i].changeMarLeft = linkarr[i].oriMarLeft+10;
		linkarr[i].changeMarRight = linkarr[i].oriMarRight+10;
		linkarr[i].onmouseover = function() {
			this.style.color = "#CCFFFF";
			startMove(this,'margin-left',this.changeMarLeft);
			startMove(this,'margin-right',this.changeMarRight);
		}
		linkarr[i].onmouseout = function() {
			this.style.color = "#FFFFFF";
			startMove(this,'margin-left',this.oriMarLeft);
			startMove(this,'margin-right',this.oriMarRight);
		}
	}
}*/

$(document).ready(function() {
			var linkarr = $(".naviLink");
			for (var i = 0; i < linkarr.length; i++) {
				linkarr[i].oriPadLeft = parseInt(getStyle(linkarr[i], 'padding-left'));
				linkarr[i].oriPadRight = parseInt(getStyle(linkarr[i], 'padding-right'));
				linkarr[i].changePadLeft = linkarr[i].oriPadLeft+5;
				linkarr[i].changePadRight = linkarr[i].oriPadRight+10;
				$(linkarr[i]).mouseover(function() {					
					$(this).animate({paddingLeft:this.changePadLeft,paddingRight:this.changePadRight,color:'#CCFFFF'},200);
				});
				$(linkarr[i]).mouseout(function() {
					$(this).stop(true,false);
					$(this).animate({paddingLeft:this.oriPadLeft,paddingRight:this.oriPadRight,color:'#FFFFFF'},200);
				});
			}
			//这段用于控制.logo的图片滑动显示--------------
			var logoUl = $(".logo>ul:eq(0)");
			var imgs = $(".logo>ul:eq(0)>li");
   			logoUl.html(logoUl.html() + logoUl.html());
   			imgs = $(".logo>ul:eq(0)>li");
   			logoUl.css("width", imgs.size() * parseInt(imgs.css("width")) + 'px');
   			var border = parseInt(logoUl.css("width")) / 2;
			setInterval(function() {
				if (parseInt(logoUl.css("left")) == -border) {
					logoUl.css("left","0px");
				}
				logoUl.animate({left:"-=1130px"},1000);
			}, 5000);
			//这段用于控制选择项的缓冲变化------------------
			var headLink = $(".choice>a");
			for (var i = 0; i < headLink.length; i++) {
				headLink[i].oriColor = getStyle(headLink[i], 'background-color');
			}
			headLink.mouseover(function() {
					$(this).stop(true,true);
					$(this).animate({'background-color':'white'},200);
				});
			headLink.mouseout(function() {
					$(this).animate({'background-color':this.oriColor},200);
				});
			//----------------------------------------------
			$('.login').click(function(){
				//$('.theme-popover-mask').fadeIn(100);
				$('.theme-popover').slideDown(200);
			})
			$('.theme-poptit .close').click(function(){
				//$('.theme-popover-mask').fadeOut(100);
				$('.theme-popover').slideUp(200);
			})
			$('.Vtoggle').click(function(){
				//$('.theme-popover-mask').fadeOut(100);
				if ($('.loginDiv').css('visibility') == 'visible') {
					$('.theme-popover').slideUp(200);
					$('.loginDiv').css('visibility','hidden');
					$('.registerDiv').css('visibility','visible');
					$('.theme-popover').slideDown(200);
				} else {
					$('.theme-popover').slideUp(200);
					$('.loginDiv').css('visibility','visible');
					$('.registerDiv').css('visibility','hidden');
					$('.theme-popover').slideDown(200);
				}
				return false;
			})
			$('.addNewComment').fadeOut(0);
			$('.addComment').click(function(){
				$('.addNewComment').fadeToggle(200);
			})
		})
//3D云标签-------------------------------
var radius = 250;
var dtr = Math.PI/180;
var d=600;
var mcList = [];
var active = false;
var lasta = 1;
var lastb = 1;
var distr = true;
var tspeed=10;
var size=250;

var mouseX=0;
var mouseY=0;

var howElliptical=1;

var aA=null;
var oDiv=null;

window.onload=function ()
{
	var i=0;
	var oTag=null;
	
	oDiv=document.getElementById('target3D');
	
	aA=oDiv.getElementsByTagName('a');
	
	for(i=0;i<aA.length;i++)
	{
		oTag={};
		
		oTag.offsetWidth=aA[i].offsetWidth;
		oTag.offsetHeight=aA[i].offsetHeight;
		
		mcList.push(oTag);
	}
	
	sineCosine( 0,0,0 );
	
	positionAll();
	
	oDiv.onmouseover=function ()
	{
		active=true;
	};
	
	oDiv.onmouseout=function ()
	{
		active=false;
	};
	
	oDiv.onmousemove=function (ev)
	{
		var oEvent=window.event || ev;
		
		mouseX=oEvent.clientX-(oDiv.offsetLeft+oDiv.offsetWidth/2);
		mouseY=oEvent.clientY-(oDiv.offsetTop+oDiv.offsetHeight/2);
		
		mouseX/=5;
		mouseY/=5;
	};
	
	setInterval(update, 30);
	
	(function (){
		var oS=document.createElement('script');
			
		oS.type='text/javascript';
			
		document.body.appendChild(oS);
	})();
};

function update()
{
	var a;
	var b;
	
	if(active)
	{
		a = (-Math.min( Math.max( -mouseY, -size ), size ) / radius 

) * tspeed;
		b = (Math.min( Math.max( -mouseX, -size ), size ) / radius 

) * tspeed;
	}
	else
	{
		a = lasta * 0.98;
		b = lastb * 0.98;
	}
	
	lasta=a;
	lastb=b;
	
	if(Math.abs(a)<=0.01 && Math.abs(b)<=0.01)
	{
		return;
	}
	
	var c=0;
	sineCosine(a,b,c);
	for(var j=0;j<mcList.length;j++)
	{
		var rx1=mcList[j].cx;
		var ry1=mcList[j].cy*ca+mcList[j].cz*(-sa);
		var rz1=mcList[j].cy*sa+mcList[j].cz*ca;
		
		var rx2=rx1*cb+rz1*sb;
		var ry2=ry1;
		var rz2=rx1*(-sb)+rz1*cb;
		
		var rx3=rx2*cc+ry2*(-sc);
		var ry3=rx2*sc+ry2*cc;
		var rz3=rz2;
		
		mcList[j].cx=rx3;
		mcList[j].cy=ry3;
		mcList[j].cz=rz3;
		
		per=d/(d+rz3);
		
		mcList[j].x=(howElliptical*rx3*per)-(howElliptical*2);
		mcList[j].y=ry3*per;
		mcList[j].scale=per;
		mcList[j].alpha=per;
		
		mcList[j].alpha=(mcList[j].alpha-0.6)*(10/6);
	}
	
	doPosition();
	depthSort();
}

function depthSort()
{
	var i=0;
	var aTmp=[];
	
	for(i=0;i<aA.length;i++)
	{
		aTmp.push(aA[i]);
	}
	
	aTmp.sort
	(
		function (vItem1, vItem2)
		{
			if(vItem1.cz>vItem2.cz)
			{
				return -1;
			}
			else if(vItem1.cz<vItem2.cz)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
	);
	
	for(i=0;i<aTmp.length;i++)
	{
		aTmp[i].style.zIndex=i;
	}
}

function positionAll()
{
	var phi=0;
	var theta=0;
	var max=mcList.length;
	var i=0;
	
	var aTmp=[];
	var oFragment=document.createDocumentFragment();
	
	//随机排序
	for(i=0;i<aA.length;i++)
	{
		aTmp.push(aA[i]);
	}
	
	aTmp.sort
	(
		function ()
		{
			return Math.random()<0.5?1:-1;
		}
	);
	
	for(i=0;i<aTmp.length;i++)
	{
		oFragment.appendChild(aTmp[i]);
	}
	
	oDiv.appendChild(oFragment);
	
	for( var i=1; i<max+1; i++){
		if( distr )
		{
			phi = Math.acos(-1+(2*i-1)/max);
			theta = Math.sqrt(max*Math.PI)*phi;
		}
		else
		{
			phi = Math.random()*(Math.PI);
			theta = Math.random()*(2*Math.PI);
		}
		//坐标变换
		mcList[i-1].cx = radius * Math.cos(theta)*Math.sin(phi);
		mcList[i-1].cy = radius * Math.sin(theta)*Math.sin(phi);
		mcList[i-1].cz = radius * Math.cos(phi);
		
		aA[i-1].style.left=mcList[i-1].cx+oDiv.offsetWidth/2-

mcList[i-1].offsetWidth/2+'px';
		aA[i-1].style.top=mcList[i-1].cy+oDiv.offsetHeight/2-

mcList[i-1].offsetHeight/2+'px';
	}
}

function doPosition()
{
	var l=oDiv.offsetWidth/2;
	var t=oDiv.offsetHeight/2;
	for(var i=0;i<mcList.length;i++)
	{
		aA[i].style.left=mcList[i].cx+l-mcList

[i].offsetWidth/2+'px';
		aA[i].style.top=mcList[i].cy+t-mcList

[i].offsetHeight/2+'px';
		
		aA[i].style.fontSize=2*mcList[i].scale/2+'em';
		
		aA[i].style.filter="alpha(opacity="+100*mcList[i].alpha

+")";
		aA[i].style.opacity=mcList[i].alpha;
	}
}

function sineCosine( a, b, c)
{
	sa = Math.sin(a * dtr);
	ca = Math.cos(a * dtr);
	sb = Math.sin(b * dtr);
	cb = Math.cos(b * dtr);
	sc = Math.sin(c * dtr);
	cc = Math.cos(c * dtr);
}
