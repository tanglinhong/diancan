
function getCookie(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = jQuery.trim(cookies[i]);
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
var csrftoken = getCookie('csrftoken');

function initialOrdersTables(){
    $(".order-list").empty();
    //从数据库加载订单数据
    $.post("/mainpage/get_my_threemonth_order",{csrfmiddlewaretoken: csrftoken},function(data,status){
        var obj=JSON.parse(data);

        var objArray=obj.order_array;
        var array_len=objArray.length;
        console.log(objArray);
        for(var i=0;i<array_len;i++){//处理每一个订单
            var orderNum=objArray[i].order_num;
            var orderTime=objArray[i].order_time;
            var orderStatus=objArray[i].status;
            var orderTotalPrice=objArray[i].total_price;
            var shopName=objArray[i].shopname;//undefined;
            var foodsArray=objArray[i].merchandise_array;
            var foodsLen=foodsArray.length;
            $('<table id="order"></table>').appendTo(".orders-list");
            var aTableHead='<thead><th colspan="6" class="shop-name-th"><div><ul><li><span class="date">'+
                        orderTime+'</span>&nbsp;&nbsp;&nbsp;订单号<span class="order-num">'+orderNum+'</span></li><li><span class="shop-name">'+
                        shopName+'</span></li><li><button class="btn-link">删除</button></li></ul></div></th></thead>';
            //console.log("head:"+aTableHead);
            var $lastTable= $(".orders-list").children("#order:last");
            $lastTable.append(aTableHead);
            $lastTable.append('<tbody><tr><td colspan="3" class="description"></td></tr><tbody>');
            var firstColum='<table class="inner-customers"><tbody class="inner-table-tbody"></tbody></table>';
            var $description=$lastTable.find(".description");
            $description.append(firstColum);
            $firstTdBody=$lastTable.find(".inner-customers tbody");
            // console.log("测试啊："+$lastTable.find(".inner-customers tbody").attr("data-ceshi"));
            // console.log("测试啊："+$lastTable.find(".inner-table-tbody").attr("data-ceshi"));
            //console.log("内潜入表单："+$lastTable.find(".inner-customers tbody").length);


            for(var j=0;j<foodsLen;j++){//处理每一个订单中的每一个商品；
                console.log(foodsLen);
                var imgPath=foodsArray[j].image;
                var foodName=foodsArray[j].title;
                var count=foodsArray[j].merchan_num;
                var price=foodsArray[j].price;
               // console.log(foodName);

                var aInnerRow='<tr><ul><li><img src="" class="food-img"></li><li><div><p>'+foodName+
                                '</p><p><span class="count">'+count+'</span><span class="multiply">x</span><span class="dollar">'+
                                price+'</span></p></div></li></ul><div class="clearfix"></div></tr>';
                console.log(aInnerRow);
                $firstTdBody.append(aInnerRow);
            }
            var otherTds='<td colspan="1" style="text-align:center"><div><p>总价</p><p>'+orderTotalPrice+'</p><p>(含配送费)</p></div></td>';
            if(orderStatus==0){

                otherTds+='<td colspan="1" style="text-align:center"><div><p>订单状态</p><p class="order-status">待店家确认</p></div></td>';
            }else if(orderNum==1){
                otherTds+='<td colspan="2" style="text-align:center"><div><p>订单状态</p><p class="order-status" style="color:#7ebf00;">店家已确认</p><button class="btn-link need-confirm">确认收货</button></div></td>';

            }else{
                otherTds+='<td colspan="1" style="text-align:center"><div><p>订单状态</p><p class="order-status has-gotten-goods">已收货</p></div></td>';

            }

            otherTds+='<td colspan="1" style="text-align:center"><button class="btn-link go-comment">评价</button></td>';
            var $lastTableTr=$lastTable.find("tr:first").append(otherTds);





        }

    })



}