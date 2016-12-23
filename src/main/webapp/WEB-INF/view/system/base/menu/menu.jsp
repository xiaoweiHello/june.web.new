<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JUNE_WEB_NEW</title>
<%@include file="../../../common/import.jsp"%>
<script type="text/javascript" src="${ctx}/js/system/base/menu/menu.js"></script>
</head>
<body>
	<div class="ibox-content">
		<div class="row row-lg">
			<div class="col-sm-12">
				<!-- Example Card View -->
				<div class="example-wrap">
					<h4 class="example-title">菜单信息</h4>
					<div class="example">
						<form id="searchForm" method="post" class="form-horizontal">
							<div class="form-group">
								<label class="col-sm-1 control-label">菜单名称</label>
								<div class="col-sm-2">
									<input type="text" class="form-control" name="menu_name" id="menu_name" />
								</div>
								<c:if test="${search eq 'hasAuthority'}">
									<button id="btn_add" type="button" class="btn btn-primary" onclick="searchInfo()">
										<span class="glyphicon glyphicon-search" aria-hidden="true"></span>查询
									</button>
								</c:if>
							</div>
						</form>
						<div class="col-md-12">
							<div id="toolbar" class="btn-group">
								<c:if test="${btnAdd eq 'hasAuthority'}">
									<button id="btn_add" type="button"
										class="btn btn-outline btn-default" onclick="addNew()">
										<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
									</button>
								</c:if>
								<c:if test="${btnEdit eq 'hasAuthority'}">
									<button id="btn_edit" type="button"
										class="btn btn-outline btn-default" onclick="editRow()">
										<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
										编辑
									</button>
								</c:if>
								<c:if test="${btnDelete eq 'hasAuthority'}">
									<button id="btn_delete" type="button"
										class="btn btn-outline btn-default" onclick="deleteRow()">
										<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>删除
									</button>
								</c:if>
							</div>
							<table id="menuInfoTable">
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" style="height: 1000px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="closemodal()">×</button>
					<p id="title"></p>
				</div>
				<form id="modalForm">
					<!--设置该属性，用于判断是新建还是编辑0：编辑，1新建  -->
					<input type="hidden" name="isNew" class="form-control" id="isNew">
					<div class="modal-body">
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label for="menu_id">菜单ID</label> 
									<input type="text" name="menu_id" class="form-control" id="menu_id">
								</div>
								<div class="form-group">
									<label for="menu_name">菜单名称</label> 
									<input type="text" name="menu_name" class="form-control" id="menu_name"> 
								</div>
								<div class="form-group">
									<label for="parent_menu_id">上级菜单</label> 
									<select class="selectpicker form-control" data-style="btn-success" id="parent_menu_id" name="parent_menu_id">
										<option value="CUS">自定义</option>
										<option value="COM">通用</option>
										<!-- TODO 这里应该能够根据菜单id展示菜单的名称 （树型菜单列表）-->
									</select>
									<input type="hidden" name="qxsj_type_msk" class="form-control" id="qxsj_type_msk">
								</div>
								<div class="form-group">
									<label for="menu_url">菜单地址</label> 
									<input type="text" name="menu_url" class="form-control" id="menu_url">
								</div>
								<div class="form-group">
									<label for="menu_icon">菜单图标</label> 
									<input type="text" name="menu_icon" class="form-control" id="menu_icon">
								</div>
								<div class="form-group">
									<label for="order_num">排序</label> 
									<input type="text" name="order_num" class="form-control" id="order_num">
								</div>
								<div class="form-group">
									<label for="menu_state">菜单状态</label> 
									<select class="selectpicker form-control" data-style="btn-success" id="menu_state" name="menu_state">
										<option value="Y">正常</option>
										<option value="N">停用</option>
									</select>
								</div>
								<div class="form-group">
									<label for="menu_notice">菜单描述</label> 
									<textarea name="menu_notice" class="form-control" id="menu_notice"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<c:if test="${btnAddSave eq 'hasAuthority' || btnEditSave eq 'hasAuthority'}">
							<button type="button" class="btn btn-primary" onclick="closemodal()">取消</button>
							<button type="submit" id="saveBtn" class="btn btn-primary">保存</button>
						</c:if>
					</div>
				</form>

			</div>
		</div>
	</div>
	<div class="modal fade bs-example-modal-sm" id="treeModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">

		<div class="modal-dialog modal-sm" style="height: auto;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="closeTreemodal()">×</button>
					权限机构选择
				</div>

				<div class="modal-body">
					<div class="row">
						<div>
							<div class="zTreeDemoBackground" style="width: 100%; height: 280px; overflow: auto;">
								<ul id="orgTree" class="ztree"></ul>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						onclick="closeTreemodal()">取消</button>
				</div>

			</div>
		</div>
	</div>
</body>
</html>