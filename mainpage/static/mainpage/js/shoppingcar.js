function recalculateTotalPrice($table){
    var totalPrice=0;
    $table.children("tbody").children("tr").each(function(){
        var count=parseInt($(this).find("span.count").text());
       // alert(count);
        var singlePrice=parseInt($(this).find("span.dollar").text());

        //alert(singlePrice);
        totalPrice+=count*singlePrice;


    });
    var deliverFee=parseInt($table.find("span.deliver-dollar").text());
    totalPrice+=deliverFee;


    //alert(totalPrice);
    $table.find("span.total-price").text(totalPrice);
}


function initialTable(){
    //---从cache中加载数据，然后初始化所有表格；
    // var obj=JSON.parse(data);
    // for(var i in obj){//处理每一个表格中，
    //     var shopId=i;
    //     console.log("商店id:"+shopId);
    //     var innerObj=obj[i];
    //     $('<table id="order" data-shop-id='+shopId+'>')
    //     for(var j in innerObj){
    //         var foodId=j;
    //         var foodCount=innerObj[j];
    //         console("商品ID："+foodId+" 商品数量："+foodCount);


    //     }



    // }


    //计算每个table的价格
    $("table").each(function(){
        recalculateTotalPrice($(this));

    });
}

function checkTableEmpty($table){
    //alert($table.find("tbody tr").length);
    if($table.find("tbody tr").length==1){
        $table.remove();
        return true;
    }
    return false;
}

function ensureOrder($table){
    //确认下单

}

function cancelOrder($table){
    $table.remove();
    if($(".shoppingcar-container").find("table").length==0){
        $(".content").append("<p>购物车已空</p>");

    }
}
