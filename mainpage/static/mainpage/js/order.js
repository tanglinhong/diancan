function initialOrdersTables{
    //从数据库加载订单数据
    $.post("#",{},function(data,status){
        var obj=JOSN.parse(data);
        var objArray=obj.order_array;
        var array_len=objArray.length;
        for(int i=0;i<array_len;i++){//处理每一个订单
            var orderNum=objArray[i].order_num;
            var orderTime=objArray[i].order_time;
            var orderStatus=objArray[i].status;
            var orderTotalPrice=objArray[i].total_price;
            var shopName=objArray[i].shop_name;
            var foodsArray=objArray[i].mechandise_array;
            var foodsLen=foodsArray.length;
            $('<table id="customers"></table>').appendTo("orders-list");
            var aTableHead='<thead><th colspan="6" class="shop-name-th"><div><ul><li><span class="date">'+
                        orderTime+'</span>&nbsp;&nbsp;&nbsp;订单号<span class="order-num">'+orderNum+'</span></li><li><span class="shop-name">'+
                        shopName+'</span></li><li><button class="btn-link">删除</button></li></ul></div></th></thead>';
            var $lastTable= $(".orders-list").children("#customers:last");
            $lastTable.append(aTableHead);
            $lastTable.append('<tbody><tr><td colspan="3" class="description"></td></tr><tbody>');
            var firstColum='<table class="inner-customers"><tbody></tbody></table>';
            var $description=$lastTable.find(".description");
            $description.append(firstColum);
            $firstTdBody=$lastTable.children(".inner-customers tbody");


            for(int j=0;j<foodsLen;j++){//处理每一个订单中的每一个商品；
                var imgPath=foodsArray[j].image;
                var foodName=foodsArray[j].title;
                var count=foodsArray[j].merchan_num;
                var price=foodsArray[j].price;

                var aInnerRow='<tr><ul><li><img src='+imgPath+' class="food-img"></li><li><div><p>'+foodName+
                                '</p><p><span class="count">'+count+'</span><span class="multiply">x</span><span class="dollar">'+
                                price+'</span></p></div></li></ul><div class="clearfix"></div></tr>';
                $.firstTdBody.append(aInnerRow);
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