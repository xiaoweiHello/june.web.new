package com.june.dto.back.login;

import java.io.Serializable;
import java.util.List;

/**
 * 菜单列表
 */
public class MenuListDto implements Serializable{
	
	private static final long serialVersionUID = -7309986015225481529L;
	private List<MenuDto> menus;

	/**
	 * @return the menus
	 */
	public List<MenuDto> getMenus() {
		return menus;
	}

	/**
	 * @param menus the menus to set
	 */
	public void setMenus(List<MenuDto> menus) {
		this.menus = menus;
	}
}
