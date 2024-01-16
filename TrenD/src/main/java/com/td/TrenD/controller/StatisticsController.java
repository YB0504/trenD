package com.td.TrenD.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.td.TrenD.model.CategoryVO;
import com.td.TrenD.service.AgeService;
import com.td.TrenD.service.GenderService;
import com.td.TrenD.service.LocationService;
import com.td.TrenD.service.CategoryService;
import com.td.TrenD.service.StatisticsService;
import com.td.TrenD.service.TrendService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.json.JSONObject;

@Controller
public class StatisticsController {

	@Autowired
	StatisticsService service;
	@Autowired
	TrendService trendService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	AgeService ageService;
	@Autowired
	GenderService genderService;
	@Autowired
	LocationService locationService;

	// '통계'를 클릭했을 때 이동할 페이지
	@RequestMapping("/Statistics")
	public String Statics(Model model) {

		List<CategoryVO> category = categoryService.get();

		JSONObject jo = new JSONObject();
		List<JSONObject> list = new ArrayList<JSONObject>();

		int index = 0;
		for (CategoryVO c : category) {
				String categoryOpt = c.getCateCd();
				int categoryCount = service.count(categoryOpt);
				jo.put("x", category.get(index).getCateNm());
				jo.put("value", categoryCount);
				list.add(jo);
				jo = new JSONObject();

				index++;
		}

		System.out.println(list);
		model.addAttribute("json", list);

		return "statistics/Statistics";
	}

	@RequestMapping("/StatisticsDetail")
	public String StatisticsDetail(Model model, CategoryVO category, String value) {

		List<Object> list = new ArrayList<Object>();
		List<Object> finalList = new ArrayList<Object>();

		if (value == null) {
			value = "연령";
		}

		List<String> vlist = new ArrayList<String>();
		List<String> clist = new ArrayList<String>();

		if (value.equals("연령")) {
			vlist = ageService.getList();
			clist = ageService.countAge(category.getCateNm());
		} else if (value.equals("성별")) {
			vlist = genderService.getList();
			clist = genderService.countGender(category.getCateNm());
		} else if (value.equals("지역")) {
			vlist = locationService.getList();
			clist = locationService.countLocation(category.getCateNm());
		} else {
			return "statistics/StatisticsDetail";
		}

		System.out.println(clist);

		for (String v : vlist) {
			int count = Collections.frequency(clist, v);
			if (count != 0) {
				list.add("'" + v + "'");
				list.add(count);
				System.out.println(list);
				finalList.add(list);
				list = new ArrayList<Object>();
			}
		}
		System.out.println(finalList);
		// clist 내부에 있는 vlist 내부의 값들 갯수를 센 후, 연관지어 전송

		model.addAttribute("list", finalList);
		model.addAttribute("value", value);
		model.addAttribute("category", category.getCateNm());
		return "statistics/StatisticsDetail";
	}

}
