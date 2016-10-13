function recalculateTotalPrice($table) {
    var totalPrice = 0;
    $table.children("tbody").children("tr").each(function() {
        var count = parseInt($(this).find("span.count").text());
        // alert(count);
        var singlePrice = parseInt($(this).find("span.dollar").text());

        //alert(singlePrice);
        totalPrice += count * singlePrice;


    });
    var deliverFee = parseInt($table.find("span.deliver-dollar").text());
    totalPrice += deliverFee;


    //alert(totalPrice);
    $table.find("span.total-price").text(totalPrice);
}


function initialTable() {
    //---从cache中加载数据，然后初始化所有表格；
    // var obj=JSON.parse(data);
    // var arrayObj=obj.shoppingcar
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
    $(".shoppingcar-container").empty();
    $.get("/mainpage/get_cart", function(data, status) {
        var obj = JSON.parse(data);
       // console.log(obj);
        var arrayObj = obj.shoppingcar_array;
        var arrayLen = arrayObj.length;
        for (var i = 0; i < arrayLen; i++) {
            //console.log("here");
            var firstTableObj = arrayObj[i];
            var shopId;
            var itemsObj;
            for (var k in firstTableObj) {
                shopId = k;
                itemsObj = firstTableObj[k];
                break;
            }
            var shopName;
            var shopDeliverFee;
            console.log("shopId:" + shopId + " 商品列表：" + itemsObj);

            $.post("#",{shop_id:shopId},function(data,status){
                var aObj=JSON.parse(data);
                shopName=aObj.shop_name;
                shopDeliverFee=aObj.deliver_fee;


            });
            $('<table id="customers" data-shop-id='+shopId+'><thead><th colspan="3" class="shop-name=th">'+shopName+'</th></thead><tbody></tbody>').appendTo(".shoppingcar-container");
            var $tableBody=$("#customers").find("tbody");
            for(var kk in itemsObj){
                var merchId=kk;
                var merchCount=itemsObj[kk];
                var foodPrice;
                var foodName;
                var foodImg;
                $.post("#",{merch_id:merchId},function(data,status){
                    var ob=JSON.parse(data);
                     foodPrice=ob.food_price;
                     foodName=ob.food_name;
                     foodImg=ob.food_img;
                });

                var aRow='<tr><td width="60%" colspan="2" class="description"><ul><li><img data-food-id='+merchId+' src='+foodImg
                        +' class="food-img"></li><li><div class="shoppingcar-description"><p>'+foodName+'</p><p><span class="count">'+merchanCount+'</span><span class="multiply"x</span><span class="dollar">'+
                        foodPrice+'</span></p></div></li></ul></td><td width="40%" class="operation"><ul><li><button class="decrease">-</button><input class="good-count" type="text">'
                        +merchanCount+'</input><button class="plus">+</button></li><li class="delete-li"><button class="btn btn-danger delete">删除</button></li></ul></td></tr>';
                $tableBody.append(aRow);

            }
            var aFooter='<tfoot><tr><td colspan="3"><div><p><b>总价:</b><span class="dollar total-price"></span></p></div><div class="clearfix"></div><p><b>+配送费</b><span class="deliver-dollar">'
            +shopDeliverFee+'</span>元</p></td></tr><tr><td colspan="3"><ul><li><button class="btn ttn-info">确定下单</button></li><li><button class="btn btn-link cancel">取消</button></li></ul></td></tr>';
            $("#customers").append(aFooter);
        }

    });

    //计算每个table的价格
    $("table").each(function() {
        recalculateTotalPrice($(this));

    });
}

function checkTableEmpty($table) {
    //alert($table.find("tbody tr").length);
    if ($table.find("tbody tr").length == 1) {
        $table.remove();
        return true;
    }
    return false;
}

function ensureOrder($table) {
 var shopId=$table.attr("data-shop-id");
 var orderTotalPrice=parseInt($table.find("span.total-price").text());
 var address_id;
 $.get("#",function(data.status){
    address_id=data;
 });
//将订单信息传入

//将订单具体信息传入
var orderDetail={};
$table.find("tbody tr").each(function(){
   var foodId=$(this).find(".food-img").attr("data-food-id");
   var foodNum=$(this).find("span.count").text();
   orderDetail[foodId]=foodNum;
});

console.log("before stringify:"+orderDetail);
var orderDetailStr=JSON.stringify(orderDetail);
console.log("after stringify:"+orderDetailStr);
$.post("#",{order_detail:orderDetailStr},function(data,status){

});



}

function cancelOrder($table) {
    $table.remove();
    if ($(".shoppingcar-container").find("table").length == 0) {
        $(".content").append("<p>购物车已空</p>");

    }
}