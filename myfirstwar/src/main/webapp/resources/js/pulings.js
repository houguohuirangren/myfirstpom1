function openDialog(div,title,w,h) {
    if (w==null){
        w=700
    }
    if (h==null){
        h=600
    }
    $("#"+div).dialog({
        title:title,
        width:w,
        height:h,
        modal:true
    });
}


function closeDialog(div){
    $("#" + div).dialog("close");
}

function  createZtree(div,data,param,did) {

    var setting={
        data:{
            key: {
                name: param.name
            },
            simpleData: {
                enable: true,
                pIdKey: param.pid
            }
        },
        view: {
            showIcon: param.icon
        },
        callback: {
            onClick: param.onclick
        },
        check: {
            enable: param.check != null ? param.check : false,
            chkboxType: param.checkType != null ? param.checkType : { "Y": "ps", "N": "ps" }
        }

    };

    var zNodes = data;
    var ztreeObject = $.fn.zTree.init($("#" + div), setting, zNodes);
    ztreeObject.expandAll(param.expand);//全部展开
    if(did != null){
        //如果did不为空，则表示did说对应的树形节点需要高亮显示

        //获得did说对应的节点
        var nodes = ztreeObject.getNodeByParam("id", did, null);
        //让这个节点呈现高亮状态
        ztreeObject.selectNode(nodes);
    }
    return ztreeObject;

}