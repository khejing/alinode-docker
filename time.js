var i = 0;
setInterval(function(){
	if(i % 5 === 0){
		console.log("i is "+i);
	}
	if(i % 10 === 0){
		console.error("error happend");
	}
	i++;
}, 1000);
