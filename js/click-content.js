/*
 *
 * 开发者：夏冬琦
 * 最后修改时间： 2018-07-02
 *
 */

window.console = window.console || (function () {
	var c = {};
	c.log = c.warn = c.debug = c.info = c.error = c.time = c.dir = c.profile = c.clear = c.exception = c.trace = c.assert = function () {};
	return c;
})();


$.ajaxSetup({
	cache: false
}); //禁用ajax get请求缓存历史页

var DQ = function (dom) {

	this.dom = dom;
	this.$dom = $(dom);
	this.dom.dq = this;

	var click_callback = function (event) {

		//this===dom

		this.dq.url = this.dq.getUrl();
		this.dq.data = this.dq.getData();

		this.dq.successMsg = this.dq.$dom.attr('data-success-msg');
		this.dq.failMsg = this.dq.$dom.attr('data-fail-msg');
		this.dq.succeedClick = this.dq.$dom.attr('data-succeed-click');
		this.dq.targetId = this.dq.getTargetId();
		this.dq.confirmMsg = this.dq.$dom.attr('data-confirm');

		this.dq.beforeStart = DQ[this.dq.$dom.attr('data-before-start')];

		if (!(this.dq.beforeStart) || !(typeof this.dq.beforeStart === 'function')) {
			this.dq.beforeStart = window[this.dq.$dom.attr('data-before-start')];

			if (!(this.dq.beforeStart) || !(typeof this.dq.beforeStart === 'function')) {
				this.dq.beforeStart = undefined;
			}
		}

		this.dq.afterJson = DQ[this.dq.$dom.attr('data-after-json')];

		if (!(this.dq.afterJson) || !(typeof this.dq.afterJson === 'function')) {
			this.dq.afterJson = window[this.dq.$dom.attr('data-after-json')];

			if (!(this.dq.afterJson) || !(typeof this.dq.afterJson === 'function')) {
				this.dq.afterJson = undefined;
			}
		}


		console.log("-------请求URL、数据、结果消息、成功后行为、视图目标和确认信息-----------------");
		console.log("url: " + this.dq.url);
		console.log("data: " + this.dq.data);
		console.log("successMsg: " + this.dq.successMsg);
		console.log("failMsg: " + this.dq.failMsg);
		console.log("succeedClick: " + this.dq.succeedClick);
		console.log("targetId: " + this.dq.targetId);
		console.log("confirmMsg: " + this.dq.confirmMsg);
		console.log("beforeStart: " + this.dq.beforeStart);
		console.log("afterJson: " + this.dq.afterJson);
		console.log("----------------------------------------------------------------");

		if (this.dq.beforeStart) this.dq.beforeStart(); //回调

		if (this.dq.confirmMsg) {
			var _this = this;
			dqConfirm(
				this.dq.confirmMsg,
				function () {
					_this.dq.action();
				}
			);

		} else {
			this.dq.action();
		}

		//event.preventDefault();
		return false;

	};

	this.$dom.click(click_callback);





}


DQ.dqClickCls = '.dq-crl-click'; //dq单击样式类名
DQ.domTargetId = '#dq-crl-content'; //主界面内容区的默认ID选择器
DQ.dialogId = 'dq-dlg'; //模态窗口ID

DQ.prototype.dqClickCls = DQ.dqClickCls;
DQ.prototype.domTargetId = DQ.domTargetId;
DQ.prototype.dialogId = DQ.dialogId;

/*
 * 获取请求url
 */
DQ.prototype.getUrl = function () {


	var url = this.$dom.attr("data-href");
	if (!url) url = this.$dom.attr("href");
	else if (!url) url = this.$dom.attr("formaction");
	else if (!url) {
		if (this.dom.form) {
			url = this.dom.form.action;
		} else if (this.$dom.attr('form')) {
			url = $('#' + this.$dom.attr('form')).prop('action');
		}
	} else if (!url) {
		if (this.$dom.parents('form:first').length > 0) {
			url = this.$dom.parents('form:first').action;
		}
	} else if (!url) {
		if ($('form:first').length > 0) {
			url = $('form:first').prop('action');
		}
	}

	return url;
};

/*
 * 获取请求数据
 */
DQ.prototype.getData = function () {

	var data = this.$dom.attr("data-params");

	//如果为json格式直接转为对象
	try {
		if (typeof JSON.parse(data) == "object") {
			data = JSON.parse(data);
		}
	} catch (e) {}

	if (!data) {
		if ($(this.dom.form)) {
			data = $(this.dom.form).serialize();
		} else if (this.$dom.attr('form')) {
			data = $('#' + this.$dom.attr('form')).serialize();
		} else if (this.$dom.parents('form:first').length > 0) {
			data = this.$dom.parents('form:first').serialize();
		} else if ($('form:first').length > 0) {
			data = $('form:first').serialize();
		}
	}

	return data;
};

DQ.prototype.getTargetId = function () {
	var targetId = this.$dom.attr("data-dq-target");
	if (!targetId) {
		targetId = this.domTargetId;
	}
	return targetId;
};

DQ.prototype.action = function () {

	var dq = this;

	var url = this.url;
	var data = this.data;
	var successMsg = this.successMsg;
	var failMsg = this.failMsg;
	var succeedClick = this.succeedClick;
	var targetId = this.targetId;

	if (targetId === this.dialogId) {
		dqOpen(url, data);
		return;
	}

	//显示加载
	var $bg = $('<div><span></span></div>').appendTo(document.body)
		.css({
			position: 'absolute',
			left: '0',
			top: '0',
			backgroundColor: '#FAFAFA',
			opacity: '0.9',
			fontSize: '14px',
			fontWeight: 'bold',
			color: '#FFFFFF',
			textAlign: 'center'
		}).css({
			width: $(window).width() + 'px',
			height: $(window).height() + 'px',
		});

	$bg.find('span')
		.css({
			position: 'absolute',
			display: 'block',
			height: '30px',
			"line-height": '30px',
			width: '0px',
			left: '25%',
			top: '45%',
			background: '#11BBEE'
		})
		.animate({
				width: "50%"
			},
			3000,
			'linear',
			function () {
				$(this).html('仍在执行中，请稍候 . . . . . .');
			}
		);

	$.ajax({
		url: url,
		data: data,
		type: "post",
		dataType: "text",
		success: function (data) {

			$bg.find('span').stop();
			$bg.remove();
			//debugger;
			try {

				var result;

				if (typeof JSON.parse(data) == "object") {
					result = JSON.parse(data);
				} else {
					result = undefined;
				}

				if (result) {
					if (dq.afterJson) { //如果设置返回json后回调，则执行之，不再执行原逻辑。
						dq.afterJson(result, dq);
						return;
					}
					if (result.success) {
						if (succeedClick) {
							$(succeedClick).click();
						}

						dqTip(result.message ? result.message : (successMsg ? successMsg : '操作成功！'), '#E9FFDD', '#33BB33', '#EEEEEE');

						//若弹窗打开，关闭弹窗
						if (dq.$dom.parents('#' + DQ.dialogId).length > 0) dqClose();

					} else {
						dqTip(result.message ? result.message : (failMsg ? failMsg : '操作失败！'), '#FFCCCC', '#FF0000', '#FFCCCC');
					}
				} else {
					if (succeedClick) {
						$(succeedClick).click();
						dqTip(data, '#E9FFDD', '#33BB33', '#EEEEEE');
					}else{
						$(dq.targetId).html(data);
						if (successMsg) {
							dqTip(successMsg, '#E9FFDD', '#33BB33', '#EEEEEE');
						}
					}
				}
			} catch (e) {

				console.log('可忽略的错误：', e);

				if (succeedClick) {
					$(succeedClick).click();
					dqTip(data, '#E9FFDD', '#33BB33', '#EEEEEE');
				}else{
					$(dq.targetId).html(data);
					if (successMsg) {
						dqTip(successMsg, '#E9FFDD', '#33BB33', '#EEEEEE');
					}
				}
				//若弹窗打开，关闭弹窗
				if (dq.$dom.parents('#' + DQ.dialogId).length > 0) dqClose();
			}


		},
		error: function (xhr) {
			//console.log($(xhr.responseText));

			$bg.find('span').stop();
			$bg.fadeOut(100,function () {
				$(this).remove();
			});

			if (dq.$dom.parents('#' + DQ.dialogId).length > 0) {
				$('#' + DQ.dialogId).html(xhr.responseText);
			} else {
				$(dq.targetId).html(xhr.responseText);
			}
			dqTip((failMsg ? failMsg : '操作失败！系统错误，错误代码：' + xhr.status + ' 。'), '#FFCCCC', '#FF0000', '#FFCCCC');

		},

		complete: function () {
			/*
			$bg.find('span').stop();
			$bg.fadeOut(100,function () {
				$(this).remove();
			});
			*/

		}
	});

};

//===============================================================


$(DQ.dqClickCls).each(function () {
	new DQ(this);

});

$(DQ.domTargetId).on("DOMNodeInserted", function (e) {

	$(this).find(".dq-crl-click").each(function () {
		if (!this.dq) {
			new DQ(this);
		}
	});

	return false;

});

//提示框
var dqTip = function (msg, bgColor, fontColor, borderColor) {
	var $tip = $('<div>' + msg + '</div>').appendTo(document.body);

	$tip.css({
		position: 'absolute',
		padding: '35px',
		backgroundColor: (bgColor ? bgColor : 'black'),
		color: (fontColor ? fontColor : 'white'),
		borderRadius: '10px',
		fontSize: '26px',
		fontWeight: 'bold',
		border: '1px solid ' + (borderColor ? borderColor : (bgColor ? bgColor : 'black')),
		boxShadow: '1px 1px 10px 1px ' + (borderColor ? borderColor : (bgColor ? bgColor : 'black')) //,
		//"z-index":'999'
		//opacity:'0.7'
	});
	$tip.css({
		left: $(window).width() / 2 - $tip.outerWidth() / 2 + 'px',
		top: $(window).height() / 2 - $tip.outerHeight() / 2 + 'px',
	});
	$tip.hide().fadeIn(500).delay(1000).fadeOut(500, function () {
		$(this).remove();
	});
};

//弹出窗
var dqOpen = function (url, data) {

	if (DQ.$dqDlg) {
		dqClose();
	}

	DQ.$dqDlg=$('<div></div>').appendTo(document.body);

	$bg = $('<div></div>').appendTo(DQ.$dqDlg)
			.css({
				position: 'absolute',
				left: '0',
				top: '0',
				width: $(window).width() + 'px',
				height: $(window).height() + 'px',
				backgroundColor: '#EEEEEE',
				opacity: '0.5'
			});

	var $dqDlgInner = $('<div id="' + DQ.dialogId + '"></div>').appendTo(DQ.$dqDlg)
		.css({
			position: 'absolute',
			left: $(window).width() / 2 - 350 + 'px',
			top: $(window).height() / 2.1 - 250 + 'px',
			boxSizing: 'border-box',
			width: '700px',
			height: '500px',
			padding: '15px',
			backgroundColor: 'white',
			border: '1px solid #CCCCCC',
			boxShadow: '1px 1px 5px 2px #CCCCCC',
			overflow: 'auto'

		});

	$.ajax({
		url: url,
		data: data,
		method: 'get',
		dataType: 'html',

		success: function (html) {

			$dqDlgInner.html(html);

			$dqDlgInner.find(".dq-crl-click").each(function () {
				if (!this.dq) {
					new DQ(this);
				}
			});

		},

		error: function (xhr) {
			$dqDlgInner.html(xhr.responseText);
		}



	});

};

dqClose = function () {
	if (DQ.$dqDlg) {
		DQ.$dqDlg.fadeOut(function(){
			$(this).remove();
			DQ.$dqDlg = undefined;
		});
	}
};


//确认框
var dqConfirm = function (msg, success, cancel) {
	if (DQ.$dqDfm) {
		DQ.$dqDfm.remove();
	}
	DQ.$dqDfm = $('<div></div>').appendTo(document.body);

	var $bg = $('<div></div>').appendTo(DQ.$dqDfm)
		.css({
			position: 'absolute',
			left: '0',
			top: '0',
			width: $(window).width() + 'px',
			height: $(window).height() + 'px',
			backgroundColor: '#EEEEEE',
			opacity: '0.5'
		});

	var $front = $('<div><div style="padding-bottom:40px;">' + msg + '</div></div>').appendTo(DQ.$dqDfm);
	$front.css({
		position: 'absolute',
		boxSizing: 'border-box',
		padding: '40px 20px 15px 20px',
		backgroundColor: 'white',
		color: 'black',
		border: '1px solid #CCCCCC',
		boxShadow: '1px 1px 5px 2px #CCCCCC',
		borderRadius: '5px',
		fontSize: '26px',
		fontWeight: 'normal'
	});

	var $opr = $('<div></div>').css({
		textAlign: 'right',
		fontSize: '16px',
		fontWeight: 'normal'
	});

	$('<div>取消</div>')
		.css({
			width: '70px',
			height: '40px',
			"line-height": '40px',
			padding: '0 5px 0 5px',
			border: '1px solid #EEEEEE',
			cursor: 'pointer',
			display: 'inline-block',
			textAlign: 'center',
			marginRight: '15px'
		})
		.on({
			mouseover: function () {
				$(this).css({
					backgroundColor: '#335599',
					color: 'white'
				});
			},
			mouseout: function () {
				$(this).css({
					background: 'transparent',
					color: 'black'
				});
			},
			click: function () {
				if (cancel) cancel();
				DQ.$dqDfm.remove();
			}

		}).appendTo($opr);

	$('<div>确定</div>')
		.css({
			width: '70px',
			height: '40px',
			"line-height": '40px',
			padding: '0 5px 0 5px',
			border: '1px solid #EEEEEE',
			cursor: 'pointer',
			display: 'inline-block',
			textAlign: 'center'
		})
		.on({
			mouseover: function () {
				$(this).css({
					backgroundColor: '#335599',
					color: 'white'
				});
			},
			mouseout: function () {
				$(this).css({
					background: 'transparent',
					color: 'black'
				});
			},
			click: function () {
				if (success) success();
				DQ.$dqDfm.remove();
			}

		}).appendTo($opr);

	$front
		.css({
				left: $(window).width() / 2 - $front.outerWidth() / 2 + 'px',
				top: $(window).height() / 2.3 - $front.outerHeight() / 2 + 'px',
			})
		.append($opr);



};
