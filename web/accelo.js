function getAccel(){
    DeviceMotionEvent.requestPermission().then(response => {
        if(response=='granted') {
           console.log("permission granted");
       }
     });
}

window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });

}