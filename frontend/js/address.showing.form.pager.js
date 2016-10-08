function showAddrTable(addr_total_num) {

    //document.getElementById("addr-list").innerHTML="<p>test</p>";
//$(".addr-list").empty();
    var every_page_row = 5; //每页展示多少条地址信息
    var page_count; //页数
    var show_count = 3; //页面上可选择的页码的数量；
    if (addr_total_num % every_page_row == 0) {
        page_count = parseInt(addr_total_num / every_page_row);
    } else {
        page_count = parseInt(addr_total_num / every_page_row) + 1;
    }

    $('<table></table>').appendTo(".addr-list");
    $(".addr-list table").addClass("customer-form");
    $('<thead><tr><th>收货人</th><th>收货地址</th><th>手机号</th><th>操作</th></tr><<thead><tbody></tbody>').appendTo(".customer-form");

    console.log("show table1");
    //得到第一页的地址信息；传入URL的参数为用户名与页码数，此处即为1
    $.post("{% url 'mainpage:show_first_page' %}", {pagenum: 1, limits: every_page_row}, function(data, status) { //返回的JSON字符串data中的key为“address_array”,value为地址对象的数组
        // data = '{"address_array":[{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":1},{"address_id":2,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0},{"address_id":3,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0},{"address_id":4,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0},{"address_id":5,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0}]}';
        //alert(data);
        console.log("show table2");
        var obj = JSON.parse(data);
        var arrayObj = obj.address_array;
        var array_len = arrayObj.length;
        //alert(array_len);
        for (var i = 0; i < array_len; i++) {
            var isDefault = arrayObj[i].is_default;
            var addressId = arrayObj[i].address_id;
            var consignee = arrayObj[i].consignee;
            var address = arrayObj[i].province + arrayObj[i].city + arrayObj[i].county + arrayObj[i].street + " " + arrayObj[i].post_code;
            var consigneePhone = arrayObj[i].tel;
            var aRow = '<tr><td width="15%">' + consignee + '</td><td width="40%">' + address + '</td><td width="20%">' + consigneePhone + '</td><td width="25%">' + '<a href="#" class="delete_a" data-addr-id=' + addressId + '>删除</a>';
            if (isDefault == 1) { //为默认地址
                aRow = aRow + '<label  class="default_label" id="default_label" style="margin-left:3px" data-addr-id=' + addressId + '>默认地址</label></td></tr>';

            } else {
                aRow = aRow + '<a href="#" class="config_default_a" style="margin-left:3px" data-addr-id=' + addressId + '>设为默认地址</a></td></tr>';

            }
            $(aRow).appendTo(".customer-form tbody");

        }



    });
    var paginationElement = '<ul class="pagination address-form-pagination"><li class="previous-page-li"><a href="#">&laquo;</a></li>';

    if (page_count < show_count) {

        for (var j = 1; j <= page_count; j++) {
            paginationElement += '<li><a href="#">' + j + '</a></li>';
        }

    } else {
        for (var j = 1; j <= show_count; j++) {
            paginationElement += '<li><a href="#">' + j + '</a></li>';
        }

    }
    paginationElement += '<li class="next-page-li"><a href="#">&raquo;</a></li></ul>'
    $(paginationElement).appendTo(".addr-list");
    $(".address-form-pagination li:nth-child(2)").addClass("active");
    disabledPreviousAndNext(page_count);
    enablePager(page_count, show_count);
    achiveFunForPreviousAndNext(page_count, show_count);
    enableOptionForForm();
}



function enableOptionForForm() {

    $(".addr-list").on("click", "a.delete_a", function(event) {
        event.preventDefault();
        var addressId = $(this).attr("data-addr-id");
        //alert(addressId);
        console.log("address_id:"+addressId);
        //删除地址，传入的参数为将要删除的地址的地址ID
        $.post("#", {
            address_id: addressId
        }, function(data, status) {
            data = 1;
            if (data == 1) { //删除成功
               // $(".addr-list").empty();//先清除已展示的地址；
                alert("删除成功");
                //重新获得地址列表
                $.get("#", function(data, status) { //获得用户地址信息数
                    data = 14;
                    addrs_total_num = data;
                    if (data == 0) {
                        isFirstAddress = 1;
                        $('<h5>您还没有添加任何地址信息，赶快添加吧！</h5>').appendTo(".addr-list");
                    } else {
                        //document.getElementById("addr-list").innerHTML="<p>test</p>";
                        $(".addr-list").empty();
						//alert("here");
                        showAddrTable(data);
                    }

                });
            }

        });

    });



    $(".addr-list").on("click", "a.config_default_a", function(event) {
        event.preventDefault();
        // alert("enableOption");
        var defaultAddressId = $(this).attr("data-addr-id");
        alert(defaultAddressId);
        //设置默认地址，传入的参数为将要设置为默认地址的地址ID
        $.post("", { default_addr_id: defaultAddressId }, function(data, status) {
            data = 1;
            if (data == 1) {
                alert("设置成功");
                // $(".addr-list").empty();//先清除已展示的地址；
                //重新获得地址列表；
                $.get("#", function(data, status) { //获得用户地址信息数
                    data = 14;
                    addrs_total_num = data;
                    if (data == 0) {
                        isFirstAddress = 1;
                        $('<h5>您还没有添加任何地址信息，赶快添加吧！</h5>').appendTo(".addr-list");
                    } else {
                        alert("重新获得地址");
                        showAddrTable(data);
                    }
                });
            }
        });
    });
}

function enablePager(page_count, show_count) {
    $(".pagination li").each(function() {
        if ($(this).hasClass("previous-page-li") == false && $(this).hasClass("next-page-li") == false) {
            $(this).click(function() {

                var active_page_num = Number($(".pagination li.active").children("a").html());
                $.get("#", function(data, status) { //得到第(active_page_num)页的地址数据，url传入的参数为(active_page_num)
                    $(".customer-form tbody").empty(); //先清除表格中原有的记录，
                    data = '{"address_array":[{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":1}]}';
                    var obj = JSON.parse(data);
                    var arrayObj = obj.address_array;
                    var array_len = arrayObj.length;
                    for (var i = 0; i < array_len; i++) {
                        var isDefault = arrayObj[i].is_default;
                        var addressId = arrayObj[i].address_id;
                        var consignee = arrayObj[i].consignee;
                        var address = arrayObj[i].province + arrayObj[i].city + arrayObj[i].county + arrayObj[i].street + " " + arrayObj[i].post_code;
                        var consigneePhone = arrayObj[i].tel;
                        var aRow = '<tr><td width="15%">' + consignee + '</td><td width="40%">' + address + '</td><td width="20%">' + consigneePhone + '</td><td width="25%">' + '<a href="#" class="delete_a" data-addr-id=' + addressId + '>删除</a>';
                        if (isDefault == 1) { //为默认地址
                            aRow = aRow + '<label  class="default_label" style="margin-left:3px" data-addr-id=' + addressId + '>默认地址</label></td></tr>';

                        } else {
                            aRow = aRow + '<a href="#" class="config_default_a" style="margin-left:3px" data-addr-id=' + addressId + '>设为默认地址</a></td></tr>';

                        }
                        $(aRow).appendTo(".customer-form tbody");

                    }
                });
                $(".pagination li.active").removeClass("active");
                $(this).addClass("active");
                disabledPreviousAndNext(page_count);

            });

        }
    });
}

//判断是否需要将前一页或后一页按钮置为不可用；
function disabledPreviousAndNext(page_count) {
    if ($(".pagination li:nth-last-child(2)").hasClass("active") == true && (Number($(".pagination li:nth-last-child(2)").children("a").html()) == page_count)) {
        $(".pagination li:last").addClass("disabled");
    } else {
        $(".pagination li:last").removeClass("disabled");
    }

    if ($(".pagination li:nth-child(2)").hasClass("active") == true && (Number($(".pagination li:nth-child(2)").children("a").html()) == 1)) {
        $(".pagination li:first").addClass("disabled");
    } else {
        $(".pagination li:first").removeClass("disabled");
    }
}

function achiveFunForPreviousAndNext(page_count, show_count) {
    if (page_count <= show_count) {
        $(".previous-page-li").click(function() {
            var active_page_num = Number($(".pagination li.active").children("a").html());
            $prevLi = $(".pagination li.active").prev();
            $(".pagination li.active").removeClass("active");
            $.get("#", function(data, status) { //得到第(active_page_num)-1页的地址数据，url传入的参数为(active_page_num)-1
                $(".customer-form tbody").empty(); //先清除表格中原有的记录，
                data = '{"address_array":[{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":1},{"address_id":2,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0}]}';
                var obj = JSON.parse(data);
                var arrayObj = obj.address_array;
                var array_len = arrayObj.length;
                for (var i = 0; i < array_len; i++) {
                    var isDefault = arrayObj[i].is_default;
                    var addressId = arrayObj[i].address_id;
                    var consignee = arrayObj[i].consignee;
                    var address = arrayObj[i].province + arrayObj[i].city + arrayObj[i].county + arrayObj[i].street + " " + arrayObj[i].post_code;
                    var consigneePhone = arrayObj[i].tel;
                    var aRow = '<tr><td width="15%">' + consignee + '</td><td width="40%">' + address + '</td><td width="20%">' + consigneePhone + '</td><td width="25%">' + '<a href="#" class="delete_a" data-addr-id=' + addressId + '>删除</a>';
                    if (isDefault == 1) { //为默认地址
                        aRow = aRow + '<label  class="default_label" style="margin-left:3px" data-addr-id=' + addressId + '>默认地址</label></td></tr>';

                    } else {
                        aRow = aRow + '<a href="#" class="config_default_a" style="margin-left:3px" data-addr-id=' + addressId + '>设为默认地址</a></td></tr>';

                    }
                    $(aRow).appendTo(".customer-form tbody");

                }


            });

            $prevLi.addClass("active");
            disabledPreviousAndNext(page_count);

        });

        $(".next-page-li").click(function() {
            var active_page_num = Number($(".pagination li.active").children("a").html());
            $nextLi = $(".pagination li.active").next();
            $(".pagination li.active").removeClass("active");
            $.get("#", function(data, status) { //得到第(active_page_num)+1页的地址数据，url传入的参数为(active_page_num)+1
                $(".customer-form tbody").empty(); //先清除表格中原有的记录，
                data = '{"address_array":[{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":1},{"address_id":2,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0}]}';
                var obj = JSON.parse(data);
                var arrayObj = obj.address_array;
                var array_len = arrayObj.length;
                for (var i = 0; i < array_len; i++) {
                    var isDefault = arrayObj[i].is_default;
                    var addressId = arrayObj[i].address_id;
                    var consignee = arrayObj[i].consignee;
                    var address = arrayObj[i].province + arrayObj[i].city + arrayObj[i].county + arrayObj[i].street + " " + arrayObj[i].post_code;
                    var consigneePhone = arrayObj[i].tel;
                    var aRow = '<tr><td width="15%">' + consignee + '</td><td width="40%">' + address + '</td><td width="20%">' + consigneePhone + '</td><td width="25%">' + '<a href="#" class="delete_a" data-addr-id=' + addressId + '>删除</a>';
                    if (isDefault == 1) { //为默认地址
                        aRow = aRow + '<label  class="default_label" style="margin-left:3px" data-addr-id=' + addressId + '>默认地址</label></td></tr>';

                    } else {
                        aRow = aRow + '<a href="#" class="config_default_a" style="margin-left:3px" data-addr-id=' + addressId + '>设为默认地址</a></td></tr>';

                    }
                    $(aRow).appendTo(".customer-form tbody");

                }
            });

            $nextLi.addClass("active");
            disabledPreviousAndNext(page_count);


        });
    } else {

        $(".previous-page-li").click(function() {


            if ($(".pagination li:nth-child(2)").hasClass("active") && Number($(".pagination li:nth-child(2)").children("a").html()) > 1) {
                var active_page_num = Number($(".pagination li:nth-child(2)").children("a").html());
                $.get("#", function(data, status) { //得到第(active_page_num)-1页的地址数据，url传入的参数为(active_page_num)-1
                    $(".customer-form tbody").empty(); //先清除表格中原有的记录，
                    data = '{"address_array":[{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":1},{"address_id":2,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0},{"address_id":3,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0}]}';
                    var obj = JSON.parse(data);
                    var arrayObj = obj.address_array;
                    var array_len = arrayObj.length;
                    for (var i = 0; i < array_len; i++) {
                        var isDefault = arrayObj[i].is_default;
                        var addressId = arrayObj[i].address_id;
                        var consignee = arrayObj[i].consignee;
                        var address = arrayObj[i].province + arrayObj[i].city + arrayObj[i].county + arrayObj[i].street + " " + arrayObj[i].post_code;
                        var consigneePhone = arrayObj[i].tel;
                        var aRow = '<tr><td width="15%">' + consignee + '</td><td width="40%">' + address + '</td><td width="20%">' + consigneePhone + '</td><td width="25%">' + '<a href="#" class="delete_a" data-addr-id=' + addressId + '>删除</a>';
                        if (isDefault == 1) { //为默认地址
                            aRow = aRow + '<label  class="default_label" style="margin-left:3px" data-addr-id=' + addressId + '>默认地址</label></td></tr>';

                        } else {
                            aRow = aRow + '<a href="#" class="config_default_a" style="margin-left:3px" data-addr-id=' + addressId + '>设为默认地址</a></td></tr>';

                        }
                        $(aRow).appendTo(".customer-form tbody");

                    }
                });


                $(".pagination li").each(function() {
                    if ($(this).hasClass("previous-page-li") || $(this).hasClass("next-page-li")) {

                    } else {
                        var pagernumTurnTo = Number($(this).children("a").html()) - 1;
                        $(this).children("a").html(pagernumTurnTo);

                    }

                });



            } else {
                var active_page_num = Number($(".pagination li.active").children("a").html());
                $prevLi = $(".pagination li.active").prev();
                $(".pagination li.active").removeClass("active");
                $.get("#", function(data, status) { //得到第(active_page_num)-1页的地址数据，url传入的参数为(active_page_num)-1
                    $(".customer-form tbody").empty(); //先清除表格中原有的记录，
                    data = '{"address_array":[{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":1},{"address_id":2,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0},{"address_id":3,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0},{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0}]}';
                    var obj = JSON.parse(data);
                    var arrayObj = obj.address_array;
                    var array_len = arrayObj.length;
                    for (var i = 0; i < array_len; i++) {
                        var isDefault = arrayObj[i].is_default;
                        var addressId = arrayObj[i].address_id;
                        var consignee = arrayObj[i].consignee;
                        var address = arrayObj[i].province + arrayObj[i].city + arrayObj[i].county + arrayObj[i].street + " " + arrayObj[i].post_code;
                        var consigneePhone = arrayObj[i].tel;
                        var aRow = '<tr><td width="15%">' + consignee + '</td><td width="40%">' + address + '</td><td width="20%">' + consigneePhone + '</td><td width="25%">' + '<a href="#" class="delete_a" data-addr-id=' + addressId + '>删除</a>';
                        if (isDefault == 1) { //为默认地址
                            aRow = aRow + '<label  class="default_label" style="margin-left:3px" data-addr-id=' + addressId + '>默认地址</label></td></tr>';

                        } else {
                            aRow = aRow + '<a href="#" class="config_default_a" style="margin-left:3px" data-addr-id=' + addressId + '>设为默认地址</a></td></tr>';

                        }
                        $(aRow).appendTo(".customer-form tbody");

                    }

                });
                $prevLi.addClass("active");
            }

            disabledPreviousAndNext(page_count);


        });



        $(".next-page-li").click(function() {
            if ($(".pagination li:nth-last-child(2)").hasClass("active") == true && Number($(".pagination li:nth-child(2)").children("a").html()) < page_count) {
                var active_page_num = Number($(".pagination li:nth-child(2)").children("a").html());
                $.get("#", function(data, status) { //得到第(active_page_num)+1页的地址数据，url传入的参数为(active_page_num)+1
                    $(".customer-form tbody").empty(); //先清除表格中原有的记录，
                    data = '{"address_array":[{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":1},{"address_id":2,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0},{"address_id":3,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0}]}';
                    var obj = JSON.parse(data);
                    var arrayObj = obj.address_array;
                    var array_len = arrayObj.length;
                    for (var i = 0; i < array_len; i++) {
                        var isDefault = arrayObj[i].is_default;
                        var addressId = arrayObj[i].address_id;
                        var consignee = arrayObj[i].consignee;
                        var address = arrayObj[i].province + arrayObj[i].city + arrayObj[i].county + arrayObj[i].street + " " + arrayObj[i].post_code;
                        var consigneePhone = arrayObj[i].tel;
                        var aRow = '<tr><td width="15%">' + consignee + '</td><td width="40%">' + address + '</td><td width="20%">' + consigneePhone + '</td><td width="25%">' + '<a href="#" class="delete_a" data-addr-id=' + addressId + '>删除</a>';
                        if (isDefault == 1) { //为默认地址
                            aRow = aRow + '<label  class="default_label" style="margin-left:3px" data-addr-id=' + addressId + '>默认地址</label></td></tr>';

                        } else {
                            aRow = aRow + '<a href="#" class="config_default_a" style="margin-left:3px" data-addr-id=' + addressId + '>设为默认地址</a></td></tr>';

                        }
                        $(aRow).appendTo(".customer-form tbody");
                    }
                });


                $(".pagination li").each(function() {
                    if ($(this).hasClass("previous-page-li") || $(this).hasClass("next-page-li")) {

                    } else {

                        var pagernumTurnTo = Number($(this).children("a").html()) + 1;
                        $(this).children("a").html(pagernumTurnTo);

                    }
                });



            } else {
                var active_page_num = Number($(".pagination li.active").children("a").html());
                $nextLi = $(".pagination li.active").next();
                $(".pagination li.active").removeClass("active");
                $.get("#", function(data, status) { //得到第(active_page_num)+1页的地址数据，url传入的参数为(active_page_num)+1
                    $(".customer-form tbody").empty(); //先清除表格中原有的记录，
                    data = '{"address_array":[{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":1},{"address_id":2,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0},{"address_id":3,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0},{"address_id":1,"province":"福建省","city":"宁德市","county":"周宁县","street":"玛坑乡玛坑村迎祠巷6-1号","post_code":"355408","consignee":"汤林鸿","tel":"15205148560","is_default":0}]}';
                    var obj = JSON.parse(data);
                    var arrayObj = obj.address_array;
                    var array_len = arrayObj.length;
                    for (var i = 0; i < array_len; i++) {
                        var isDefault = arrayObj[i].is_default;
                        var addressId = arrayObj[i].address_id;
                        var consignee = arrayObj[i].consignee;
                        var address = arrayObj[i].province + arrayObj[i].city + arrayObj[i].county + arrayObj[i].street + " " + arrayObj[i].post_code;
                        var consigneePhone = arrayObj[i].tel;
                        var aRow = '<tr><td width="15%">' + consignee + '</td><td width="40%">' + address + '</td><td width="20%">' + consigneePhone + '</td><td width="25%">' + '<a href="#" class="delete_a" data-addr-id=' + addressId + '>删除</a>';
                        if (isDefault == 1) { //为默认地址
                            aRow = aRow + '<label  class="default_label" style="margin-left:3px" data-addr-id=' + addressId + '>默认地址</label></td></tr>';

                        } else {
                            aRow = aRow + '<a href="#" class="config_default_a" style="margin-left:3px" data-addr-id=' + addressId + '>设为默认地址</a></td></tr>';

                        }
                        $(aRow).appendTo(".customer-form tbody");
                    }

                });
                $nextLi.addClass("active");
            }

            disabledPreviousAndNext(page_count);
        });
    }



}