package com.june.service.back.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import com.june.common.BaseService;
import com.june.dao.back.common.LogMethodDao;
import com.june.dto.back.common.LogMethodDto;

/**
 * 操作日志Service
 * LogMethodService <br>
 * 
 * @author 王俊伟 wjw.happy.love@163.com
 * @blog https://www.github.com/junehappylove
 * @date 2017年2月24日 上午7:43:28
 * @version 1.0.0
 */
@Service 
public class LogMethodService extends BaseService<LogMethodDao, LogMethodDto> {

	@Autowired 
	private LogMethodDao logMethodDao;

	/**
	 * 获取登录用户id
	 * 
	 * @return
	 */
	public String getLoginUserId() {
		// 获取登录管理员帐号名
		String userId = (String) SecurityUtils.getSubject().getPrincipal();
		if (userId == null || userId.equals("")) {
			return null;
		}
		// 判断该用户是否存在
		int num = logMethodDao.userExit(userId);
		if (num < 1) {
			return null;
		}
		return userId;
	}

	/**
	 * 获取参数
	 * 
	 * @param request
	 */
	public String getParams(HttpServletRequest request) {
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		Map<String, String> paramsMap2 = new HashMap<String, String>();
		boolean isAjaxCall = this.isAjaxCall(request);
		if (isAjaxCall) {
			paramsMap = WebUtils.getParametersStartingWith(request, "");
			paramsMap2 = getParameterMap(paramsMap);
		} else {
			Map<String, String[]> paramsMap3 = new HashMap<String, String[]>();
			paramsMap3 = request.getParameterMap();
			paramsMap2 = getParameterMap2(paramsMap3);
		}
		String params = mapToString(paramsMap2);
		return params;
	}

	/**
	 * 从request中获得参数Map，并返回可读的Map
	 * 
	 * @param request
	 * @return
	 */
	public Map<String, String> getParameterMap(Map<String, Object> map) {
		// 返回值Map
		Map<String, String> returnMap = new HashMap<String, String>();
		Iterator<Entry<String, Object>> entries = map.entrySet().iterator();
		Map.Entry<String, Object> entry;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			entry = (Map.Entry<String, Object>) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				for (int i = 0; i < values.length; i++) {
					value = values[i] + ",";
				}
				value = value.substring(0, value.length() - 1);
			} else {
				value = valueObj.toString();
			}

			if (valueObj != null && !StringUtils.isBlank(value) && !name.equals("_") && name != "_") {
				returnMap.put(name, value);
			}
		}
		return returnMap;
	}

	public Map<String, String> getParameterMap2(Map<String, String[]> map) {
		// 返回值Map
		Map<String, String> returnMap = new HashMap<String, String>();
		Iterator<Entry<String, String[]>> entries = map.entrySet().iterator();
		Map.Entry<String, String[]> entry;
		String name = "";
		String value = "";
		while (entries.hasNext()) {
			entry = (Map.Entry<String, String[]>) entries.next();
			name = (String) entry.getKey();
			Object valueObj = entry.getValue();
			if (null == valueObj) {
				value = "";
			} else if (valueObj instanceof String[]) {
				String[] values = (String[]) valueObj;
				for (int i = 0; i < values.length; i++) {
					value = values[i] + ",";
				}
				value = value.substring(0, value.length() - 1);
			} else {
				value = valueObj.toString();
			}

			if (valueObj != null && !StringUtils.isBlank(value) && !name.equals("_") && name != "_") {
				returnMap.put(name, value);
			}
		}
		return returnMap;
	}

	/**
	 * 将map转为String
	 * 
	 * @param map
	 * @return
	 */
	public String mapToString(Map<String, String> map) {
		if (map == null) {
			return "";
		}
		StringBuffer sb = new StringBuffer();
		List<String> keys = new ArrayList<String>(map.keySet());

		for (int i = 0; i < keys.size(); i++) {
			String key = keys.get(i);
			String value = map.get(key).toString();
			sb.append(key + "=" + value);
			sb.append(",");
		}
		String s = sb.toString();
		if (s.endsWith(",")) {
			s = s.substring(0, s.lastIndexOf(","));
		}
		return s;
	}
}
